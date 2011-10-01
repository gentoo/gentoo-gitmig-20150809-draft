# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsmf/libsmf-1.3.ebuild,v 1.1 2011/10/01 07:57:07 radhermit Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Standard MIDI File format library"
HOMEPAGE="http://libsmf.sourceforge.net/api/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc readline static-libs"

RDEPEND=">=dev-libs/glib-2.2:2
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_with readline) \
		$(use_enable static-libs static)
}

src_compile() {
	default

	if use doc ; then
		doxygen doxygen.cfg || die
	fi
}

src_install() {
	default
	remove_libtool_files all
	use doc && dohtml -r api
}
