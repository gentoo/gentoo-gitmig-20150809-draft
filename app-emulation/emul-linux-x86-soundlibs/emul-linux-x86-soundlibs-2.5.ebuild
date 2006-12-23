# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-2.5.ebuild,v 1.1 2006/12/23 17:15:08 peper Exp $

DESCRIPTION="Sound libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-2.0
		!<=app-emulation/emul-linux-x86-medialibs-1.1"

S=${WORKDIR}

RESTRICT="nostrip"

src_install() {
	cp -RPvf ${WORKDIR}/* ${D}/
}
