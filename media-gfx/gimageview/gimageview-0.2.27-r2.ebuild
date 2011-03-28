# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimageview/gimageview-0.2.27-r2.ebuild,v 1.8 2011/03/28 19:46:44 ssuominen Exp $

EAPI=2
inherit eutils libtool

DESCRIPTION="Powerful GTK+ based image & movie viewer"
HOMEPAGE="http://gtkmmviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkmmviewer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 x86"
IUSE="nls imlib wmf mng svg xine mplayer"

RDEPEND="x11-libs/gtk+:2
	>=media-libs/libpng-1.4
	wmf? ( >=media-libs/libwmf-0.2.8 )
	mng? ( >=media-libs/libmng-1.0.3 )
	svg? ( >=gnome-base/librsvg-1.0.3 )
	xine? ( >=media-libs/xine-lib-0.9.13-r3 )
	mplayer? ( >=media-video/mplayer-0.92 )
	imlib? ( media-libs/imlib )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-sort_fix.diff \
		"${FILESDIR}"/${P}-gtk12_fix.diff \
		"${FILESDIR}"/${P}-gtk2.patch

	elibtoolize
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with wmf libwmf) \
		$(use_with mng libmng) \
		$(use_with svg librsvg) \
		$(use_with xine) \
		$(use_enable mplayer) \
		--with-gtk2 \
		--enable-splash
}

src_install() {
	einstall \
		desktopdir="${D}"/usr/share/applications \
		gimv_docdir="${D}"/usr/share/doc/${PF} || die

	find "${D}" -name '*.la' -exec rm -f {} +
}
