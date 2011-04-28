# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/polkit-gnome/polkit-gnome-0.101-r1.ebuild,v 1.5 2011/04/28 10:20:44 phajdan.jr Exp $

EAPI=3
inherit autotools eutils

DESCRIPTION="A dbus session bus service that is used to bring up authentication dialogs"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="doc examples +introspection"

# XXX: Change to gtk3 when it gets added to ~arch
# Strict dep on the same polkit shouldn't be needed, but we can't be sure
RDEPEND=">=x11-libs/gtk+-2.17.1:2[introspection?]
	>=sys-auth/polkit-${PV}
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

	# polkit-gnome-authentication-agent-1.desktop was removed, manually added now
	# translations are lost though, what to do about that?
	insinto /etc/xdg/autostart
	doins "${FILESDIR}"/polkit-gnome-authentication-agent-1.desktop

	find "${D}" -name '*.la' -exec rm -f {} +
}
