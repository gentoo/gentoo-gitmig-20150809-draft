# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/wfmath/wfmath-0.3.11.ebuild,v 1.3 2011/11/11 09:18:33 phajdan.jr Exp $

EAPI=2
DESCRIPTION="Worldforge math library"
HOMEPAGE="http://www.worldforge.org/dev/eng/libraries/wfmath"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc static-libs"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static)
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		emake -C doc docs || die "emake doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	if use doc; then
		dohtml doc/html/*
	fi
	if ! use static-libs ; then
		find "${D}" -type f -name '*.la' -exec rm {} + \
			|| die "la removal failed"
	fi
}
