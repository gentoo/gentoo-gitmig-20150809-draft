# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/qtsvc/qtsvc-0.1-r1.ebuild,v 1.24 2005/03/03 18:13:52 ciaranm Exp $

inherit eutils

DESCRIPTION="A QT frontend for svc"
SRC_URI="http://www.together.net/~plomp/${P}.tar.gz"
HOMEPAGE="http://www.together.net/~plomp/qtsvc.html"

SLOT="0"
IUSE=""

LICENSE="BSD Artistic"
KEYWORDS="x86 sparc"

DEPEND="=x11-libs/qt-2*"
RDEPEND="${DEPEND}
	>=sys-process/daemontools-0.70"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/qtsvc-0.1.diff
}

src_compile() {
	QTDIR=/usr/qt/2 ./configure --host=${CHOST} || die
	#make CPPFLAGS=\"${CPPFLAGS} -fkeep-inline-functions\" || die
	make || die
}

src_install() {
	dobin qtsvc/qtsvc
	dodoc README qtsvc/MANUAL qtsvc/LICENSE qtsvc/PROGRAMMING
}
