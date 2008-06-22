# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/terminal/terminal-0.2.8.ebuild,v 1.2 2008/06/22 22:21:16 mr_bones_ Exp $

inherit fdo-mime gnome2-utils

MY_P=${P/t/T}

DESCRIPTION="Terminal for Xfce desktop environment, based on vte library."
HOMEPAGE="http://www.xfce.org/projects/terminal"
SRC_URI="mirror://xfce/xfce-4.4.2/src/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="dbus debug startup-notification doc"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXrender
	startup-notification? ( x11-libs/startup-notification )
	dbus? ( dev-libs/dbus-glib )
	x11-libs/vte
	>=xfce-extra/exo-0.3.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	doc? ( dev-libs/libxslt )"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable startup-notification) \
		$(use_enable dbus) \
		$(use_enable debug) \
		$(use_enable doc xsltproc)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog HACKING NEWS README THANKS
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
