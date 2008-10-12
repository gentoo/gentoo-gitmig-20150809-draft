# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-user-share/gnome-user-share-0.40.ebuild,v 1.1 2008/10/12 20:14:39 eva Exp $

inherit eutils autotools gnome2

DESCRIPTION="Personal file sharing for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bluetooth"

# FIXME: could libnotify be made optional ?
#        is consolekit needed or not ?
RDEPEND=">=dev-libs/glib-2.16.0
	>=x11-libs/gtk+-2.12
	>=gnome-base/gconf-2.10
	>=sys-apps/dbus-1.1.1
	>=dev-libs/dbus-glib-0.70
	>=net-dns/avahi-0.6
	>=www-servers/apache-2.2
	x11-libs/libnotify
	bluetooth? ( >=app-mobilephone/obex-data-server-0.3 )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.17"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	if ! built_with_use www-servers/apache apache2_modules_dav \
	apache2_modules_dav_fs apache2_modules_authn_file \
	apache2_modules_auth_digest apache2_modules_authz_groupfile ; then
		eerror "You need to build www-servers/apache with APACHE2_MODULES='dav dav_fs authn_file auth_digest authz_groupfile'"
		die "re-emerge www-servers/apache with APACHE2_MODULES='dav dav_fs authn_file auth_digest authz_groupfile'"
	fi

	G2CONF="${G2CONF} --enable-avahi --disable-howl
		--with-modules-path=/usr/lib/apache2/modules/"
}

src_unpack() {
	gnome2_src_unpack

	# this file will be recreated with the correct module path
	#rm data/dav_user_2.2.conf

	# the configuration script looks for httpd, but we call it apache2
	sed -i -e "s:\(AC_PATH_PROG(\[HTTPD\], \)\[httpd\]:\1[apache2]:" \
		configure.in || die "sed failed"

	eautoreconf
}
