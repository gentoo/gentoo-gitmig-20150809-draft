# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.99.3_pre20041022-r1.ebuild,v 1.1 2005/03/29 06:06:09 chriswhite Exp $

inherit eutils

DESCRIPTION="Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc64 ~sparc"
IUSE="X nls lirc aalib libcaca readline curl ncurses"

S=${WORKDIR}/${PN}

DEPEND="media-libs/libpng
	>=media-libs/xine-lib-1.0
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )
	aalib? ( media-libs/aalib )
	gnome? ( =gnome-base/orbit-0* )
	directfb? ( >=dev-libs/DirectFB-0.9.9 )
	curl?( >=net-misc/curl-7.10.2 )
	libcaca? (media-libs/libcaca)
	ncurses? (sys-libs/ncurses)"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-configure-checks.patch
	epatch ${FILESDIR}/${PN}-desktop-fixes.patch
}

src_compile() {

	./autogen.sh

	econf \
		$(use_enable lirc) \
		$(use_enable nls) \
		$(use_with X x) \
		$(use_with aalib) \
		$(use_with libcaca) \
		$(use_with curl) \
		$(use_with readline) \
		$(use_with ncurses) \
	|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	for res in 16 22 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins ${S}/misc/desktops/xine_${res}x${res}.png xine.png
	done

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
