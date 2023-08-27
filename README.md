# Perfect-Cadence
An iOS app for runners which syncs music bpm with running cadence. UQCS Hackathon 2023 Project.

<img width="256" alt="icon_main" src="https://github.com/leafthelegend/Perfect-Cadence/assets/66891654/bb37f644-d3fd-4af1-8642-20063214ff16">

## What's the idea?
Have you ever tried to listen to music while running or working out, but the tempo keeps messing up your flow? It's why I don't listen to music on my runs - I always end up matching my cadence to the beat of the music, and my pace is all out. Enter Perfect Cadence! 

Perfect Cadence is a mobile app which adjusts the bpm of your music to match the pace at which you're running. Simply load up your library, press play and Perfect Cadence will detect the cadence at which your feet are moving and set the speed of your music to match. The built-in DJ algorithm automatically selects songs from your library which have a bpm close to your current pace, and will add them to your queue. Then while the song is playing the music player will adjust the tempo in real time to perfectly match your pace.

If you want to use your music as motivation to push your pace, then you can set a cadence target and Perfect Cadence will lock the bpm of all your songs to some multiple of this target. As long as you stay in time with the music you'll match your desired pace! This setting is also great for workouts.

## How does it work?
Perfect Cadence chooses songs from your Apple music library, but it uses the Spotify API for calculating BPMs. When you open the app, you sign in with your Spotify account. Then the app loads in all the songs on your Device and processes them to determine their tempos in BPM. The main view of the app is a media player which allows play, pause and skip functionality.

In order to determine the pace at which you're running, Perfect Cadence uses the Core Motion API to access the pedometer on your phone. This gives the app live cadence and pace data. While a song is playing, the app calculates how to adjust playback speed so that the BPM matches your current cadence. The app will try to keep a song's tempo within 25% of the original, so it might set a speed which is half or double your pace (the beats still line up). 

To determine which song to play next, the app searches your library for songs which have a BPM closest to your current running speed, and queues it for playback after the current song. It also makes sure not to repeat songs too often.

If you choose to set a target pace, then the app will choose songs close to this target and adjust their tempo so that the beat of every song is locked perfectly to the target you set.

<img src="https://github.com/leafthelegend/Perfect-Cadence/assets/66891654/f5dfb89f-00be-470f-86be-624c983c6300" alt="phone screen" width="200"/>
<img src="https://github.com/leafthelegend/Perfect-Cadence/assets/66891654/1f33f3a1-5127-4d47-9f3e-d7e514741054" alt="phone screen" width="200"/>
