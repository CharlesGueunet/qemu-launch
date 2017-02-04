This script is under active development. It allows to start
a Qemu Virtual Machine with network and shared data with the host.

Copyright (C) 2016 Charles Gueunet

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Usage

Some variable at the beginning of the script allow to customize the VM:<br/>
* Hostname
* Name
* SSH port

Reading the comment will tell you how to share folder between the host and the guest

## Installation

For the first boot (installation) of the Virtual Machine, you may want to change
the boot argument to :
```
-boot d
```
This will boot on the iso.
For usual launch, we start on the hard drive file ($drive).

# Git

This git is maintained by **Charles Gueunet** \<charles.gueunet+qemu@gmail.com\>
