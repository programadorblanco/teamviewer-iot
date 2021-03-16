#!/bin/bash
   # read the config
   . /boot/firstboot.conf

   # detect architecture
   [[ "$(lscpu | grep 'Architecture' | awk '{print $NF}')" = arm* ]] || { echo "TeamViewer IoT agent firstboot error: Unsupported CPU architecture!"; exit 1; }
   [[ "$(cat /proc/cpuinfo | grep Revision | awk '{print $NF}')" = [abc]* ]] && { arch="armv7"; } || { arch="armv5"; }

   # set hostname
   if [ ! -z "${Hostname}" ]; then
      raspi-config nonint do_hostname "${Hostname}"
      hostname -b "${Hostname}"
      systemctl restart avahi-daemon
   fi

   # wait for network connectivity
   until ( ping -w 1 www.teamviewer.com &> /dev/null ); do
      { sleep 10; }
   done

   # download teamviewer-iot-agent
   wget https://download.teamviewer-iot.com/agents/latest/${arch}/teamviewer-iot-agent-${arch}_latest_armhf.deb -O /tmp/teamviewer-iot-agent-${arch}_latest_armhf.deb &> /dev/null

   # checking dpkg lock
   while ( fuser /var/lib/dpkg/lock ); do
      { sleep 10; }
   done

   # install teamviewer-iot-agent
   dpkg -i /tmp/teamviewer-iot-agent-${arch}_latest_armhf.deb &> /dev/null

   # checking package
   [ -f /usr/bin/teamviewer-iot-agent ] || { exit 1; }

   # wait for online status
   until ( /usr/bin/teamviewer-iot-agent info | grep "Status: Online" > /dev/null ); do
      { sleep 10; }
   done

   # accept license
   /usr/bin/teamviewer-iot-agent license accept > /dev/null

   # assign to an account with assignment token
   [ ! -z "$TV_ASSIGNTOKEN" ] && { /usr/bin/teamviewer-iot-agent assign -t "$TV_ASSIGNTOKEN" -g "$TV_ASSIGNGROUP" > /dev/null; }

   # enable FrameBuffer on GUI versions of Raspbian
   if [ -f /usr/bin/startlxde-pi ]; then
      /usr/bin/teamviewer-iot-agent configure set EnableRemoteScreen 1
      /usr/bin/teamviewer-iot-agent configure set RemoteScreenChannels \"FBD:/dev/fb0\"
      /usr/bin/teamviewer-iot-agent restart
   fi

   # remove files
   [ -f /etc/rc.local ] && [ -f /boot/activate_firstboot_and_resize ] && { rm -f /boot/activate_firstboot_and_resize; sed -i "19d" /etc/rc.local; }
   [ -f /boot/firstboot.conf ] && { rm -f /boot/firstboot.conf; }
   [ -f /boot/Readme ] && { rm -f /boot/Readme; }
   rm -f $0
