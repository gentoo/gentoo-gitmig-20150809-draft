# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdstyler/dvdstyler-1.7.1.ebuild,v 1.1 2009/01/18 13:25:07 dragonheart Exp $

WX_GTK_VER=2.8
inherit eutils autotools wxwidgets

MY_P=DVDStyler-${PV}

DESCRIPTION="DVDStyler is a cross-platform DVD authoring System"
HOMEPAGE="http://www.dvdstyler.de"
SRC_URI="mirror://sourceforge/dvdstyler/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnome"

COMMON_DEPEND="
	media-video/ffmpeg
	=x11-libs/wxGTK-2.8*
	>=media-libs/wxsvg-1.0
	>=media-libs/libexif-0.6.16
	gnome? ( >=gnome-base/libgnomeui-2.0 )"
RDEPEND="${COMMON_DEPEND}
	virtual/cdrtools
	>=media-video/dvdauthor-0.6.14
	>=app-cdr/dvd+rw-tools-7.1
	>=app-cdr/dvdisaster-0.71.0"
# doco says .16	>=media-video/dvdauthor-0.6.16
DEPEND="${COMMON_DEEND}
	dev-util/pkgconfig
	>=sys-devel/gettext-0.17"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf --with-wx-config="${WX_CONFIG}"
	emake || die 'compile failed'
}
src_install() {
	emake DESTDIR="${D}" install || die "failed to install"
	rm  "${D}"usr/share/doc/${PN}/COPYING "${D}"usr/share/doc/${PN}/INSTALL
	mv "${D}"usr/share/doc/${PN} "${D}"usr/share/doc/${PF}

	make_desktop_entry dvdstyler DVDStyler /usr/share/dvdstyler/rc/dvdstyler.png AudioVideo
}
