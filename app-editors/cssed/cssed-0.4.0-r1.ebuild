# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/cssed/cssed-0.4.0-r1.ebuild,v 1.7 2011/03/01 06:48:08 radhermit Exp $

EAPI=1

inherit autotools eutils toolchain-funcs

DESCRIPTION="a GTK2 application to help create and maintain CSS style sheets for web developing"
HOMEPAGE="http://cssed.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="plugins"

RDEPEND="x11-libs/gtk+:2
	>=dev-libs/atk-1.4.0
	>=dev-libs/glib-2.2.3
	>=media-libs/fontconfig-2.2.0-r2
	>=x11-libs/pango-1.2.1-r1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
	sed -i -e "/^cssed_LINK/s:g++:$(tc-getCXX) \$(LDFLAGS):" src/Makefile.am
	eautoreconf
}

src_compile() {
	econf $(use_with plugins plugin-headers)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	dodoc AUTHORS ChangeLog NEWS README
}
