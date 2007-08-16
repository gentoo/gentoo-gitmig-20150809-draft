# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdstyler/dvdstyler-1.5.1.ebuild,v 1.1 2007/08/16 09:20:15 dragonheart Exp $

inherit eutils wxwidgets

MY_P=DVDStyler-${PV}

DESCRIPTION="DVDStyler is a cross-platform DVD authoring System"
HOMEPAGE="http://www.dvdstyler.de"
SRC_URI="mirror://sourceforge/dvdstyler/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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
	echo -e "all:\n\ninstall:"> install.win32/Makefile.in
	myconf="${myconf} --with-wx-config=${WX_CONFIG}"
	econf ${myconf} || die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "failed to install"
	rm  "${D}"usr/share/doc/${PN}/COPYING "${D}"usr/share/doc/${PN}/INSTALL
	mv "${D}"usr/share/doc/${PN} "${D}"usr/share/doc/${PF}

	make_desktop_entry dvdstyler DVDStyler /usr/share/dvdstyler/rc/dvdstyler.png AudioVideo
}
