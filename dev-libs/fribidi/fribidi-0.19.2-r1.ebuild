# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/fribidi/fribidi-0.19.2-r1.ebuild,v 1.7 2011/11/05 15:13:04 grobian Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="http://fribidi.org/"
SRC_URI="http://fribidi.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND=">=dev-libs/glib-2.4:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS NEWS README ChangeLog THANKS TODO )

src_prepare() {
	# bug #318569
	epatch "${FILESDIR}/${P}-glib.patch"
	epatch "${FILESDIR}/${P}-nodoc.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
