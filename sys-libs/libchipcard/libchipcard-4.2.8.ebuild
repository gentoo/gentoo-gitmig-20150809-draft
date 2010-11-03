# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-4.2.8.ebuild,v 1.9 2010/11/03 13:51:25 ssuominen Exp $

EAPI="2"

DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
HOMEPAGE="http://www.libchipcard.de"
SRC_URI="http://www2.aquamaniac.de/sites/download/download.php?package=02&release=14&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ~ppc64 sparc x86"
IUSE="doc"

DEPEND=">=sys-libs/gwenhywfar-3.8.1
	dev-libs/libgcrypt
	net-libs/gnutls
	sys-apps/hal"
RDEPEND="${DEPEND}"

src_configure() {
	econf --localstatedir=/var || die
}

src_install() {
	make DESTDIR="${D}" install || die

	keepdir /var/log/chipcard \
		/var/lib/chipcardd/newcerts \
		/usr/lib/chipcardd/server/lowlevel

	doinitd "${FILESDIR}/chipcardd4" || die

	dodoc AUTHORS ChangeLog README doc/CERTIFICATES doc/CONFIG doc/IPCCOMMANDS || die
	if use doc ; then
		docinto tutorials
		dodoc tutorials/*.{c,h,xml} tutorials/README || die
	fi

	find "${D}" -name '*.la' -delete
}
