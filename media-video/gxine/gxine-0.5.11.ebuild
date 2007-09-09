# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gxine/gxine-0.5.11.ebuild,v 1.6 2007/09/09 16:31:09 corsair Exp $

inherit eutils nsplugins fdo-mime libtool

DESCRIPTION="GTK+ Front-End for libxine"
HOMEPAGE="http://xine.sourceforge.net/"
LICENSE="GPL-2"

RDEPEND="media-libs/libpng
	>=media-libs/xine-lib-1_beta10
	>=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.6
	>=dev-lang/spidermonkey-1.5_rc6-r1
	lirc? ( app-misc/lirc )
	nsplugin? ( dev-libs/nspr )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	xinerama? ( x11-libs/libXinerama )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	x11-libs/libXt
	x11-libs/libXaw"

IUSE="nls lirc nsplugin xinerama"

SLOT="0"
# Those needs spidermonkey: ~sparc
KEYWORDS="amd64 ppc ppc64 x86"

SRC_URI="mirror://sourceforge/xine/${P}.tar.bz2"

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

	dodoc AUTHORS ChangeLog NEWS README

	use nsplugin && inst_plugin /usr/$(get_libdir)/gxine/gxineplugin.so
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
