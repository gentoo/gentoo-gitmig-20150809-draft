# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-modules/vmware-modules-1.0.0.16.ebuild,v 1.2 2007/07/12 06:39:56 mr_bones_ Exp $

KEYWORDS="-* ~amd64 ~x86"
VMWARE_VER="VME_V6" # THIS VALUE IS JUST A PLACE HOLDER

inherit vmware-mod

VMWARE_MODULE_LIST="vmmon vmnet vmblock"
SRC_URI="x86? ( mirror://vmware/software/vmplayer/VMware-player-2.0.0-45731.i386.tar.gz )
		 amd64? ( mirror://vmware/software/vmplayer/VMware-player-2.0.0-45731.x86_64.tar.gz )"
VMWARE_MOD_DIR="vmware-player-distrib/lib/modules/source/"
