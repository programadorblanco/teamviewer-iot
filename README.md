rpi 4
wget https://download.teamviewer-iot.com/agents/2.14.13/armv7/teamviewer-iot-agent-armv7_2.14.13_armhf.deb;
sudo dpkg -i teamviewer-iot-agent-armv7_2.14.13_armhf.deb;
sudo teamviewer-iot-agent assign -t 12063664-sNc6xMaOoQ2CWnjaOiBD -g $'raiz'


rpi 2/3
wget https://download.teamviewer-iot.com/agents/2.14.13/armv7/teamviewer-iot-agent-armv7_2.14.13_armhf.deb;
sudo dpkg -i teamviewer-iot-agent-armv7_2.14.13_armhf.deb;
sudo teamviewer-iot-agent assign -t 12063664-sNc6xMaOoQ2CWnjaOiBD -g $'raiz'

rpi 1
wget https://download.teamviewer-iot.com/agents/2.14.13/armv5/teamviewer-iot-agent-armv5_2.14.13_armhf.deb;
sudo dpkg -i teamviewer-iot-agent-armv5_2.14.13_armhf.deb;
sudo teamviewer-iot-agent assign -t 12063664-sNc6xMaOoQ2CWnjaOiBD -g $'raiz'

rpi zero
wget https://download.teamviewer-iot.com/agents/2.14.13/armv5/teamviewer-iot-agent-armv5_2.14.13_armhf.deb;
sudo dpkg -i teamviewer-iot-agent-armv5_2.14.13_armhf.deb;
sudo teamviewer-iot-agent assign -t 12063664-sNc6xMaOoQ2CWnjaOiBD -g $'raiz'
