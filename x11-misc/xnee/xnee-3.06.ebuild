# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnee/xnee-3.06.ebuild,v 1.2 2010/07/10 19:27:18 ssuominen Exp $

EAPI=2
inherit autotools eutils
# virtualx

DESCRIPTION="Program suite to record, replay and distribute user actions."
HOMEPAGE="http://www.sandklef.com/xnee/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome xosd"

RDEPEND="x11-libs/libX11
	x11-libs/libXtst
	gnome? ( x11-libs/gtk+:2
		>=gnome-base/libgnomeui-2
		>=gnome-base/gconf-2
		>=gnome-base/gnome-panel-2 )"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	dev-util/pkgconfig
	sys-devel/gettext
	gnome? ( || ( media-gfx/imagemagick[jpeg,png]
		media-gfx/graphicsmagick[imagemagick,jpeg,png] ) )"

# This needs RECORD extension from X.org server which isn't necessarily
# enabled. Xlib: extension "RECORD" missing on display ":0.0".
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.05-asneeded.patch
	eautoreconf
}

src_configure() {
	local myconf=""

	if use xosd; then
		myconf="--enable-xosd --enable-verbose --enable-buffer_verbose"
	else
		myconf="--disable-xosd --disable-verbose --disable-buffer_verbose"
	fi

	econf \
		--disable-dependency-tracking \
		$(use_enable gnome gui) \
		$(use_enable gnome gnome-applet) \
		--enable-cli \
		--enable-lib \
		--disable-static-programs \
		${myconf}
}

src_test() {
	Xemake check || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README TODO
	use gnome && make_desktop_entry gnee Gnee ${PN} "Utility;GTK"
}
