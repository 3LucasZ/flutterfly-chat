import asyncio
import websockets
import os
import json
import sys

#import ssl

#use os to get ip and remove /n
serverIP = os.popen('ipconfig getifaddr en0').read()[:-1]
#serverIP = 'localhost'
port = 5000

#app state
tilesDict = {
    'tiles':[
        {
            'message': 'hello user',
            'sender': 'bot'
        }
    ]
}
users = set()

async def connection_handler(websocket, path):
    #global variables to manipulate
    global users
    global messages

    #handle a new connection
    print('new connection:', websocket)
    users.add(websocket)
    await websocket.send(json.dumps(tilesDict))

    #create a listener for the connection
    while True:
        try:
            tileDict = await websocket.recv()
        except:
            continue
        
        tileDict = json.loads(tileDict)
        print("Received:", tileDict)
        tilesDict['tiles'].append(tileDict)
        print("tiles dict:", tilesDict)
        
        usersToRemove = set()
        for user in users:
            try:
                await user.send(json.dumps(tilesDict))
            except:
                usersToRemove.add(user)
                print("A user disconnected")
        for user in usersToRemove:
            users.remove(user)
        
#wss (secure version of ws)
#ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)

if __name__ == '__main__':
    try:
        start_server = websockets.serve(connection_handler, serverIP, port)
        asyncio.get_event_loop().run_until_complete(start_server)
        print("Running on: " + serverIP + ':' + str(port))
        asyncio.get_event_loop().run_forever()
    except KeyboardInterrupt:
        sys.exit()