# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/fribidi/fribidi-0.19.2-r2.ebuild,v 1.3 2012/05/18 08:04:46 ago Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="http://fribidi.org/"
SRC_URI="http://fribidi.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND=">=dev-libs/glib-2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS README ChangeLog THANKS TODO"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-glib-2.31.patch \
		"${FILESDIR}"/${P}-nodoc.patch

	eautoreconf
}

src_configure() {
	# --with-glib=yes is required for #345621 to ensure "Requires: glib-2.0" is
	# present in /usr/lib/pkgconfig/fribidi.pc
	econf \
		$(use_enable static-libs static) \
		--with-glib=yes
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
