# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-1.0-r1.ebuild,v 1.4 2005/02/03 19:33:10 eradicator Exp $

DESCRIPTION="Sound libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/distfiles/emul-linux-x86-soundlibs-${PV}.tar.bz2
		http://dev.gentoo.org/~kugelfang/distfiles/emul-linux-x86-soundlibs-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=">=app-emulation/emul-linux-x86-glibc-1.0"

S=${WORKDIR}

src_install() {
	cp -aRpvf ${WORKDIR}/* ${D}/
	dobin ${FILESDIR}/aoss32
	# This was just a backwards compat lib, but it breaks stuff now
	rm ${D}/emul/linux/x86/usr/lib/libasound.so.1
}
