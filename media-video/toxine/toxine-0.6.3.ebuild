# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/toxine/toxine-0.6.3.ebuild,v 1.2 2005/08/19 19:31:52 flameeyes Exp $

inherit eutils

DESCRIPTION="Text user interface to xine media player"
HOMEPAGE="http://toxine.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X ncurses aalib libcaca"

DEPEND="sys-libs/readline
	>=media-libs/xine-lib-1_rc3
	aalib? ( media-libs/aalib )
	libcaca? ( media-libs/libcaca )
	ncurses? ( sys-libs/ncurses )
	X? ( virtual/x11 )"
RDEPEND="${DEPEND}
	sys-devel/autoconf
	sys-devel/automake"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-gcc4.patch
	epatch ${FILESDIR}/${P}-nox.patch

	aclocal -I m4 || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
	libtoolize --copy --force || die "libtoolize failed"
}

src_compile() {
	econf \
		$(use_with X x) \
		$(use_with ncurses) \
		$(use_with aalib) \
		$(use_with libcaca) \
		--disable-dependency-tracking \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc NEWS README AUTHORS ChangeLog
}

