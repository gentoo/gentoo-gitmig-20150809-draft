# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/polkit-gnome/polkit-gnome-0.99.ebuild,v 1.5 2011/03/04 12:37:51 tomka Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A dbus session bus service that is used to bring up authentication dialogs"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="doc examples +introspection"

RDEPEND=">=x11-libs/gtk+-2.17.1:2
	>=sys-auth/polkit-0.97
	introspection? ( >=dev-libs/gobject-introspection-0.6.2 )
	!lxde-base/lxpolkit"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.35.0
	dev-util/pkgconfig
	gnome-base/gnome-common
	sys-devel/gettext
	doc? ( >=dev-util/gtk-doc-1.3 )"

src_prepare() {
	# polkit-gnome is useful also for LXDE, XFCE, and others
	sed -i \
		-e 's:OnlyShowIn=GNOME:NotShowIn=KDE:' \
		src/polkit-gnome-authentication-agent-1.desktop.in.in || die

	# Fix make check, bug 298345
	epatch "${FILESDIR}"/${PN}-0.95-fix-make-check.patch

	if use doc; then
		# Fix parallel build failure, bug 293247
		epatch "${FILESDIR}"/${PN}-0.95-parallel-build-failure.patch

		gtkdocize || die
		eautoreconf
	fi
}

src_configure() {
	# Do we need USE static-libs ? By user request.
	econf \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable doc gtk-doc) \
		$(use_enable examples) \
		$(use_enable introspection)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS HACKING NEWS

	find "${D}" -name '*.la' -exec rm -f '{}' +
}
