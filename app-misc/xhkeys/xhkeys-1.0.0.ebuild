# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/xhkeys/xhkeys-1.0.0.ebuild,v 1.2 2003/07/01 22:31:32 aliz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="The application allows to assign a particular action to any key or key combination."
SRC_URI="http://www.geocities.com/wmalms/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/wmalms"
LICENSE="GPL-2"
DEPEND="x11-base/xfree"
RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	dobin xhkeys xhkconf
#	exeinto /etc/init.d/
#	doexe ${FILESDIR}/xhkeys

	dodoc README VERSION
}
