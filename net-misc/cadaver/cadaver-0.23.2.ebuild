# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cadaver/cadaver-0.23.2.ebuild,v 1.9 2010/06/22 20:06:35 arfrever Exp $

inherit autotools eutils

DESCRIPTION="Command-line WebDAV client."
HOMEPAGE="http://www.webdav.org/cadaver"
SRC_URI="http://www.webdav.org/cadaver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc x86"
IUSE="nls"

DEPEND=">=net-libs/neon-0.27.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-disable-nls.patch"

	rm -fr lib/{expat,intl,neon}
	sed -e "/NE_REQUIRE_VERSIONS/s/28/& 29 30/" \
		-e "s:lib/neon/Makefile lib/intl/Makefile ::" -i configure.ac
	sed -e "s/^\(SUBDIRS.*=\).*/\1/" -i Makefile.in
	AT_M4DIR="m4 m4/neon" eautoreconf
}

src_compile() {
	econf \
		$(use_enable nls) \
		--with-libs=/usr
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc BUGS ChangeLog FAQ NEWS README THANKS TODO
}
