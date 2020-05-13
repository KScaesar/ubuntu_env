#!/bin/bash

# http://iqotom.com/?p=965
if [ -f /lib/systemd/system/rc-local.service ]; then
    sudo ln -fs /lib/systemd/system/rc-local.service /etc/systemd/system/rc-local.service
    sudo touch /etc/rc.local
    echo '#!/bin/bash' | sudo tee /etc/rc.local
    sudo systemctl enable rc-local
fi
