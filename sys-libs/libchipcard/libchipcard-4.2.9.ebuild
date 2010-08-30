# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-4.2.9.ebuild,v 1.2 2010/08/30 17:58:01 flameeyes Exp $

EAPI=2

DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www.aquamaniac.de/sites/download/download.php?package=02&release=15&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=sys-libs/gwenhywfar-3.11.3
	dev-libs/libgcrypt
	net-libs/gnutls
	sys-apps/hal"

src_configure() {
	econf \
		--localstatedir=/var \
		--disable-dependency-tracking \
		--with-docpath=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die

	keepdir /var/log/chipcard \
		/var/lib/chipcardd/newcerts \
		/usr/lib/chipcardd/server/lowlevel

	doinitd "${FILESDIR}"/chipcardd4 || die

	dodoc AUTHORS ChangeLog NEWS README TODO \
		doc/{CERTIFICATES,CONFIG,IPCCOMMANDS}

	rm "${D}"/etc/init.d/chipcardd

	if use doc; then
		docinto tutorials
		dodoc tutorials/*.{c,h,xml} tutorials/README
	fi

	find "${D}" -name '*.la' -delete
}
