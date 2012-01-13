# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnome-keyring/libgnome-keyring-2.32.0.ebuild,v 1.14 2012/01/13 20:23:49 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome2 eutils autotools

DESCRIPTION="Compatibility library for accessing secrets"
HOMEPAGE="http://live.gnome.org/GnomeKeyring"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~sparc-solaris"
IUSE="debug doc test"

RDEPEND=">=sys-apps/dbus-1.0
	>=gnome-base/gnome-keyring-2.29[test?]
	!<gnome-base/gnome-keyring-2.29"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1.9 )"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable debug)
		$(use_enable test tests)"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	gnome2_src_prepare

	# Remove unneeded test file.
	epatch "${FILESDIR}/${P}-drop-test.patch"

	# Don't run tests if a testing enabled gnome-keyring-daemon is not enabled.
	epatch "${FILESDIR}/${P}-run-test.patch"

	# Don't let tests to hang, bug #356141
	epatch "${FILESDIR}/${PN}-2.32.0-hang-tests.patch"

	# Remove silly CFLAGS
	sed 's:CFLAGS="$CFLAGS -Werror:CFLAGS="$CFLAGS:' \
		-i configure.in configure || die "sed failed"

	# Remove DISABLE_DEPRECATED flags
	sed -e '/-D[A-Z_]*DISABLE_DEPRECATED/d' \
		-i configure.in configure || die "sed 2 failed"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check
}
