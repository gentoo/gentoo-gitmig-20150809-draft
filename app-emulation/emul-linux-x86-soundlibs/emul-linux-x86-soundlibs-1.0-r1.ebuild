# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-1.0-r1.ebuild,v 1.1 2004/12/08 13:56:22 eradicator Exp $

DESCRIPTION="Sound libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/distfiles/emul-linux-x86-soundlibs-${PV}.tar.bz2
		http://dev.gentoo.org/~kugelfang/distfiles/emul-linux-x86-soundlibs-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="=app-emulation/emul-linux-x86-glibc-1*"

S=${WORKDIR}

src_install() {
	cp -aRpvf ${WORKDIR}/* ${D}/
	dobin ${FILESDIR}/aoss32
}
