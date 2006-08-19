# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-modules/vmware-modules-1.0.0.15.ebuild,v 1.3 2006/08/19 16:35:19 ikelos Exp $

inherit vmware-mod

SRC_URI="http://download3.vmware.com/software/vmserver/VMware-server-1.0.1-29996.tar.gz"
KEYWORDS="-* ~amd64 ~x86"
VMWARE_VER="VME_S1B1"

VMWARE_MOD_DIR="vmware-server-distrib/lib/modules/source"
