# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libgksu/libgksu-2.0.12.ebuild,v 1.6 2009/11/22 19:09:19 klausman Exp $

GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="A library for integration of su into applications"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="nls doc"

BOTH=">=x11-libs/gtk+-2.12
	>=gnome-base/gconf-2
	>=gnome-base/gnome-keyring-0.4.4
	x11-libs/startup-notification
	>=gnome-base/libgtop-2
	nls? ( >=sys-devel/gettext-0.14.1 )"

DEPEND="${BOTH}
	doc? ( >=dev-util/gtk-doc-1.2-r1 )
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.35.5
	>=dev-util/pkgconfig-0.19"

RDEPEND="${BOTH}
	app-admin/sudo"

DOCS="AUTHORS ChangeLog"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable nls)"
}

src_unpack() {
	gnome2_src_unpack

	# Fix compilation on bsd
	epatch "${FILESDIR}"/${PN}-2.0.0-fbsd.patch

	# Fix wrong usage of LDFLAGS, bug #226837
	epatch "${FILESDIR}/${PN}-2.0.7-libs.patch"

	# Use po/LINGUAS
	epatch "${FILESDIR}/${PN}-2.0.7-polinguas.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}
