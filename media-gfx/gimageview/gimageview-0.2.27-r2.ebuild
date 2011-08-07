# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimageview/gimageview-0.2.27-r2.ebuild,v 1.9 2011/08/07 06:05:45 ssuominen Exp $

EAPI=4
inherit eutils libtool

DESCRIPTION="Powerful GTK+ based image & movie viewer"
HOMEPAGE="http://gtkmmviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkmmviewer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 x86"
IUSE="nls wmf mng svg xine mplayer"

# note: bzip2 is for libbz2
RDEPEND="app-arch/bzip2
	x11-libs/gtk+:2
	>=media-libs/libpng-1.4
	x11-libs/libXinerama
	wmf? ( >=media-libs/libwmf-0.2.8 )
	mng? ( media-libs/libmng )
	svg? ( gnome-base/librsvg )
	xine? ( media-libs/xine-lib )
	mplayer? ( media-video/mplayer )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-sort_fix.diff \
		"${FILESDIR}"/${P}-gtk12_fix.diff \
		"${FILESDIR}"/${P}-gtk2.patch \
		"${FILESDIR}"/${P}-libpng15.patch

	# desktop-file-validate
	sed -i -e '/^Term/s:0:false:' -e '/^Icon/s:.png::' etc/${PN}.desktop.in || die

	elibtoolize
}

src_configure() {
	econf \
		--disable-imlib \
		$(use_enable nls) \
		--enable-splash \
		$(use_enable mplayer) \
		--with-gtk2 \
		$(use_with mng libmng) \
		$(use_with svg librsvg) \
		$(use_with wmf libwmf) \
		$(use_with xine)
}

src_install() {
	einstall \
		desktopdir="${D}"usr/share/applications \
		gimv_docdir="${D}"usr/share/doc/${PF}

	find "${D}"usr -name '*.la' -exec rm -f {} +
}
