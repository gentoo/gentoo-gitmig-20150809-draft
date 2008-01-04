# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvxml/dvxml-0.1.5.ebuild,v 1.1 2008/01/04 08:37:13 dev-zero Exp $

inherit eutils flag-o-matic

DESCRIPTION="dvxml provides some convenient stuff on top of the xmlwrapp package"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/${PN}/download/${P}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvxml/html/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND="dev-libs/dvutil
	>=dev-libs/xmlwrapp-0.5.0
	dev-libs/libxslt
	dev-libs/libxml2"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-namespace_usage.patch"

	sed -i 's/^\(SUBDIRS =.*\)doc\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"

	filter-ldflags -Wl,--as-needed
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README AUTHORS
	use doc && dohtml -r doc/html/*
}
