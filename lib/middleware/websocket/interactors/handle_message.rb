require './lib/middleware/websocket/interactors/updates/race_update'
require './lib/middleware/websocket/interactors/updates/timer_update'
require './lib/middleware/websocket/interactors/handle_new_connection'
require './lib/typinggame_server/interactors/players_rooms/update_player_room'
require './lib/typinggame_server/interactors/players/fetch_player'

module Websocket
  module Interactor
    class HandleMessage
      def call(data:, connection:)
        room_id = connection.env['PATH_INFO'][1..].to_i
        uuid = data['uuid']

        if uuid && data.length == 1
          Interactor::HandleNewConnection.new.call(
            uuid: uuid, connection: connection
          )
        end

        if data.key?('position') && data.key?('uuid')
          if player_verified?(uuid: uuid)
            update_player_position(data: data, room_id: room_id)
            RaceUpdate.new.call(connection: connection, room_id: room_id)
          end
        elsif data.key?('countdown') && data.key?('uuid')
          if player_verified?(uuid: uuid)
            TimerUpdate.new.call(connection: connection, room_id: room_id)
          end
        end
      end

      private

      def update_player_position(data:, room_id:)
        Interactors::PlayersRooms::UpdatePlayerRoom.new.call(
          data: data, room_id: room_id
        )
      end

      def player_verified?(uuid:)
        player = Interactors::Players::FetchPlayer.new.call(uuid: uuid).player

        player.nil? ? false : true
      end
    end
  end
end
