# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gxine/gxine-0.5.903.ebuild,v 1.1 2008/08/03 02:29:29 chutzpah Exp $

inherit eutils nsplugins fdo-mime libtool

DESCRIPTION="GTK+ Front-End for libxine"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="nls hal lirc nsplugin xinerama xcb"

RDEPEND="media-libs/libpng
	>=media-libs/xine-lib-1.1.8
	>=x11-libs/gtk+-2.8
	>=dev-libs/glib-2.10
	>=x11-libs/pango-1.12
	>=dev-lang/spidermonkey-1.5_rc6-r1
	lirc? ( app-misc/lirc )
	nsplugin? ( dev-libs/nspr )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	xcb? ( x11-libs/libxcb )
	hal? ( sys-apps/hal )
	xinerama? ( x11-libs/libXinerama )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	x11-libs/libXt
	x11-libs/libXaw"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/ac_have_xinerama/ s:text:test:' \
		"${S}/configure"{,.ac}

	elibtoolize
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable lirc) \
		$(use_with nsplugin browser-plugin) \
		$(use_with xcb) \
		$(use_with hal) \
		$(use_with xinerama) \
		--disable-gtk-compat \
		--disable-dependency-tracking || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS ChangeLog NEWS README{,.{cs,de}_l10n TODO BUGS

	use nsplugin && inst_plugin /usr/$(get_libdir)/gxine/gxineplugin.so
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
