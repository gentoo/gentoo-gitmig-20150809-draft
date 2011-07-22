# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-motif/emul-linux-x86-motif-20110722.ebuild,v 1.1 2011/07/22 19:22:33 pacho Exp $

EAPI="4"

inherit emul-linux-x86

LICENSE="MIT MOTIF"

KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-xlibs-${PV}
	!<app-emulation/emul-linux-x86-xlibs-20110129"
