# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.99.4-r2.ebuild,v 1.4 2005/09/14 00:05:18 flameeyes Exp $

inherit eutils autotools

PATCHLEVEL="7"
DESCRIPTION="Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${P}.tar.gz
	http://digilander.libero.it/dgp85/gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="X nls lirc aalib libcaca readline curl ncurses"

DEPEND="media-libs/libpng
	>=media-libs/xine-lib-1.0
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )
	aalib? ( media-libs/aalib )
	libcaca? ( media-libs/libcaca )
	curl? ( >=net-misc/curl-7.10.2 )
	ncurses? ( sys-libs/ncurses )"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/${PV}
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	rm misc/xine-bugreport
	local myconf=""

	econf \
		$(use_enable lirc) \
		$(use_enable nls) \
		$(use_with X x) \
		$(use_with aalib) \
		$(use_with libcaca) \
		$(use_with curl) \
		$(use_with readline) \
		$(use_with ncurses) \
		${myconf} || die
	emake || die "Make failed!"
}

src_install() {
	make DESTDIR=${D} docdir=/usr/share/doc/${PF} docsdir=/usr/share/doc/${PF} install || die

	dodoc AUTHORS ChangeLog NEWS README

	for res in 16 22 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins ${S}/misc/desktops/xine_${res}x${res}.png xine.png
	done
	insinto /usr/share/pixmaps
	doins ${S}/misc/desktops/xine.xpm
}
