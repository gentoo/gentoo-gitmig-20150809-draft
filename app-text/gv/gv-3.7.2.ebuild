# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gv/gv-3.7.2.ebuild,v 1.2 2011/06/12 12:17:43 maekke Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Viewer for PostScript and PDF documents using Ghostscript"
HOMEPAGE="http://www.gnu.org/software/gv/"
SRC_URI="mirror://gnu/gv/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="xinerama"

DEPEND="x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/Xaw3d
	app-text/ghostscript-gpl
	xinerama? ( x11-libs/libXinerama )"

src_prepare() {
	epatch "${FILESDIR}"/gv-3.6.1-a0.patch

	if ! use xinerama; then
		sed -i -e 's:Xinerama:dIsAbLe&:' configure.ac || die
	fi

	sed -i \
		-e "s:-dGraphicsAlphaBits=2:\0 -dAlignToPixels=0:" \
		src/Makefile.am || die #135354

	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-scrollbar-code
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	doicon "${FILESDIR}"/gv_icon.xpm
	make_desktop_entry gv GhostView gv_icon "Graphics;Viewer"
}
