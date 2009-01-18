# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdstyler/dvdstyler-1.5-r1.ebuild,v 1.5 2009/01/18 13:25:07 dragonheart Exp $

inherit wxwidgets

MY_P=DVDStyler-${PV}

DESCRIPTION="DVDStyler is a cross-platform DVD authoring System"
HOMEPAGE="http://www.dvdstyler.de"
SRC_URI="mirror://sourceforge/dvdstyler/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="gnome"

RDEPEND="app-cdr/dvd+rw-tools
	>=media-video/dvdauthor-0.6.10
	media-video/mpgtx
	>=media-video/mjpegtools-1.8.0
	=x11-libs/wxGTK-2.6*
	media-libs/netpbm
	>=media-libs/wxsvg-1.0_beta7
	virtual/cdrtools
	virtual/libc
	gnome? ( >=gnome-base/libgnomeui-2.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S="${WORKDIR}"/${MY_P}

src_compile() {
	export WX_GTK_VER="2.6"
	need-wxwidgets gtk2
	myconf="${myconf} --with-wx-config=${WX_CONFIG}"
	econf ${myconf} || die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "failed to install"
	rm  "${D}"usr/share/doc/${PN}/COPYING "${D}"usr/share/doc/${PN}/INSTALL
	mv "${D}"usr/share/doc/${PN} "${D}"usr/share/doc/${PF}
}
