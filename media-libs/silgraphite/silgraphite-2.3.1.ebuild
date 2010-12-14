# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/silgraphite/silgraphite-2.3.1.ebuild,v 1.17 2010/12/14 04:03:28 mattst88 Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Rendering engine for complex non-Roman writing systems"
HOMEPAGE="http://graphite.sil.org/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="|| ( CPL-0.5 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="pango truetype xft"

RDEPEND="xft? ( x11-libs/libXft )
	truetype? ( media-libs/freetype:2 )
	pango? ( x11-libs/pango media-libs/fontconfig )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-aligned_access.patch"
}

src_configure() {
	econf \
		$(use_with xft) \
		$(use_with truetype freetype) \
		$(use_with pango pangographite)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
}
