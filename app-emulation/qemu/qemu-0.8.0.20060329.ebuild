# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu/qemu-0.8.0.20060329.ebuild,v 1.1 2006/03/29 11:25:06 lu_zero Exp $

DESCRIPTION="qemu emulator and abi wrapper meta ebuild"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="~app-emulation/qemu-softmmu-${PV}
		~app-emulation/qemu-user-${PV}
		!<=app-emulation/qemu-0.7.0"

