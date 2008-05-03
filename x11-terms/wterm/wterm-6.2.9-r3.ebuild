# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/wterm/wterm-6.2.9-r3.ebuild,v 1.2 2008/05/03 15:48:09 opfer Exp $

inherit eutils

DESCRIPTION="A fork of rxvt patched for fast transparency and a NeXT scrollbar"
HOMEPAGE="http://wterm.org"
SRC_URI="mirror://sourceforge/wterm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="cjk"

DEPEND="x11-libs/libXpm
	>=x11-wm/windowmaker-0.80.1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Security bug 219762
	epatch "${FILESDIR}/${P}-display-security-issue.patch"
}

src_compile() {
	local myconf

	myconf="--enable-menubar --enable-graphics --with-term=rxvt \
		--enable-transparency --enable-next-scroll --enable-xpm-background"

	use cjk && myconf="$myconf --enable-kanji"

	econf ${myconf} || die "configure failed"
	emake || die "parallel make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	insinto /usr/share/pixmaps
	doins *.xpm *.tiff
}
