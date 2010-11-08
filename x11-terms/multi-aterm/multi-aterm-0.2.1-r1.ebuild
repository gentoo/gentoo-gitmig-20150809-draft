# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/multi-aterm/multi-aterm-0.2.1-r1.ebuild,v 1.10 2010/11/08 12:40:47 nelchael Exp $

EAPI=2
inherit eutils

DESCRIPTION="Terminal emulator with transparency support as well as rxvt backwards compatibility with tab support"
HOMEPAGE="http://www.nongnu.org/materm/materm.html"
SRC_URI="http://www.nongnu.org/materm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"
IUSE="cjk debug jpeg png"

RDEPEND="x11-libs/libXpm
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-initialize-vars.patch \
		"${FILESDIR}"/${P}-display-security-issue.patch \
		"${FILESDIR}"/${P}-libpng14.patch

	sed -i \
		-e 's:png_check_sig:png_sig_cmp:' \
		configure || die
}

src_configure() {
	econf \
		--enable-transparency \
		--enable-fading \
		--enable-xterm-scroll \
		--enable-half-shadow \
		--enable-graphics \
		--enable-mousewheel \
		--with-x \
		--with-xpm=/usr \
		$(use_enable cjk kanji) \
		$(use_enable debug) \
		$(use_enable jpeg) \
		$(use_enable png)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS TODO
	newdoc doc/TODO TODO.2
}
