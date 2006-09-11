# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/cairomm/cairomm-1.2.2.ebuild,v 1.1 2006/09/11 18:42:01 allanonjl Exp $

inherit eutils

DESCRIPTION="C++ bindings for the Cairo vector graphics library"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc examples"
RDEPEND=">=x11-libs/cairo-1.2.0"
DEPEND="${RDEPEND}
	app-doc/doxygen"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	if ! use examples; then
		# don't waste time building the examples
		sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
			die "sed Makefile.in failed"
	fi
}

src_compile() {
	econf \
		$(use_enable doc docs) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use examples; then
		cp -R examples ${D}/usr/share/doc/${PF}
	fi
}
