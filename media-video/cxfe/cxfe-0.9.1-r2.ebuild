# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cxfe/cxfe-0.9.1-r2.ebuild,v 1.4 2007/01/30 19:18:44 aballier Exp $

inherit eutils

DESCRIPTION="A command line interface for xine."
HOMEPAGE="http://www.rtwnetwork.com/cxfe/"

SRC_URI="ftp://ftp.rtwnetwork.com/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="lirc"

RDEPEND=">=media-libs/xine-lib-1_rc1
	   || ( ( x11-libs/libX11
	      x11-libs/libXext )
	   virtual/x11 )
	   lirc? ( app-misc/lirc )
	   sys-libs/ncurses"

DEPEND="${RDEPEND}
	   || ( ( x11-libs/libX11
	      x11-libs/libXext )
	   virtual/x11 )"

src_unpack() {
	unpack ${A}
	mv cxfe ${P}
	cd ${P}
	epatch "${FILESDIR}/gcc-2.95-fix.patch"
	epatch "${FILESDIR}/max-osd-fix.patch"
	epatch "${FILESDIR}/xv-default.patch"
	epatch "${FILESDIR}/disable-dpms.patch"
	epatch "${FILESDIR}/position-osd.patch"
	epatch "${FILESDIR}/black-background.patch"

	# add missing space, see #82684
	sed -i -e 's/\-lXext\@LDFLAGS/\-lXext \@LDFLAGS/' Makefile.in
	epatch "${FILESDIR}/${P}-asneeded.patch"
}

src_install() {
	dobin cxfe
	dodoc README TODO lircrc-example
}
