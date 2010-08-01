# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-exchange/evolution-exchange-2.30.2.ebuild,v 1.4 2010/08/01 12:01:38 fauli Exp $

EAPI="2"

inherit autotools gnome2

DESCRIPTION="Evolution module for connecting to Microsoft Exchange"
HOMEPAGE="http://www.novell.com/products/desktop/features/evolution.html"
LICENSE="GPL-2"

SLOT="2.0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="debug doc static"

RDEPEND="
	>=mail-client/evolution-${PV}
	>=gnome-extra/evolution-data-server-${PV}[ldap,kerberos]
	>=dev-libs/glib-2.16.0
	>=x11-libs/gtk+-2.10
	>=gnome-base/gconf-2.0
	>=gnome-base/libbonobo-2.20.3
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	dev-libs/libxml2
	net-libs/libsoup:2.4
	>=net-nds/openldap-2.1.30-r2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-openldap
		--disable-static
		$(use_with debug e2k-debug)
		$(use_with static static-ldap)"
}

src_prepare() {
	gnome2_src_prepare

	# FIXME: Fix compilation flags crazyness
	sed 's/CFLAGS="$CFLAGS $WARNING_FLAGS"//' \
		-i configure.ac configure || die "sed 1 failed"

	sed 's:-DG.*DISABLE_DEPRECATED::g' -i configure.ac configure \
		|| die "sed 2 failed"

	sed 's:-DG.*DISABLE_SINGLE_INCLUDES::g' -i configure.ac configure \
		|| die "sed 3 failed"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}
