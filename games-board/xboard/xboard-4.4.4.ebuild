# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xboard/xboard-4.4.4.ebuild,v 1.3 2010/10/11 07:28:12 hwoarang Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="GUI for gnuchess and for internet chess servers"
HOMEPAGE="http://www.gnu.org/software/xboard/"
SRC_URI="mirror://gnu/xboard/${P}.tar.gz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="Xaw3d +default-font zippy"
RESTRICT="test" #124112

RDEPEND="Xaw3d? ( x11-libs/Xaw3d )
	x11-libs/libXpm
	x11-libs/libXaw
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXext
	x11-libs/libICE
	default-font? ( media-fonts/font-adobe-100dpi )"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${P}.tar.gz
}

src_prepare() {
	epatch "${FILESDIR}"/${P}*
	sed -i \
		-e '/icons/s:\$(datadir):/usr/share:' \
		Makefile.am \
		|| die 'sed failed'
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_with Xaw3d) \
		$(use_enable zippy)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS COPYRIGHT ChangeLog NEWS README TODO ics-parsing.txt
	use zippy && dodoc zippy.README
	dohtml FAQ.html
	doicon "${DISTDIR}"/xboard.png
	make_desktop_entry ${PN} "Xboard (Chess)"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "No chess engines are emerged by default! If you want a chess engine"
	elog "to play with, you can emerge gnuchess or crafty."
	elog "Read xboard FAQ for information."
	if ! use default-font ; then
		ewarn "Read the xboard(6) man page for specifying the font for xboard to use."
	fi
}
