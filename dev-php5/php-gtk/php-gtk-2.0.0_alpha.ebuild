# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-gtk/php-gtk-2.0.0_alpha.ebuild,v 1.1 2007/02/20 16:40:23 anant Exp $

PHP_EXT_NAME="php_gtk2"
inherit php-ext-source-r1

DESCRIPTION="PHP 5 bindings for the Gtk+ 2 library"
HOMEPAGE="http://gtk.php.net/"
SRC_URI="http://gtk.php.net/distributions/${PN}-${PV/_alpha/}alpha.tar.gz"

LICENSE="PHP"
SLOT="2"
KEYWORDS="~x86"
IUSE="debug mozembed nolibglade sourceview"

S="${WORKDIR}/${PN}-${PV/_alpha/}alpha"

RDEPEND=">=dev-lang/php-5.1.2
	>=x11-libs/gtk+-2.6.0
	>=dev-libs/glib-2.6.0
	>=x11-libs/pango-1.8.0
	>=dev-libs/atk-1.6.0
	!nolibglade? ( >=gnome-base/libglade-2.5.0 )
	mozembed? ( || ( >=www-client/mozilla-1.7.0 >=www-client/mozilla-firefox-1.5.0 ) )
	sourceview? ( >=x11-libs/gtksourceview-1.6.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

pkg_setup() {
	require_php_cli
	if use debug; then
		require_php_with_use cli pcre debug
	else
		if has_debug; then
			# PHP has debug enabled, but PHP-GTK doesn't
			eerror "Please enable the debug USE flag!"
			die
		fi
		require_php_with_use cli pcre
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Allow building against firefox
	epatch "${FILESDIR}/gtkmozembed.patch"
}

src_compile() {
	# Can't use php-ext-source-r1_src_compile
	# because PHP-GTK 2 uses buildconf and not autoconf
	./buildconf

	if use nolibglade; then
		GLCONF=" --disable-libglade"
	else
		GLCONF=""
	fi

	econf \
		$(use_enable debug ) \
		$(use_enable mozembed ) \
		$(use_enable sourceview) \
		$GLCONF \
		|| die "Configure failed!"

	emake || die "Compilation failed!"
}

src_install() {
	# Can't use php-ext-source-r1_src_install
	# because it looks for {ext}-default.so,
	# that too in the wrong location
	insinto "${EXT_DIR}"
	newins "${S}/modules/${PHP_EXT_NAME}.so" "${PHP_EXT_NAME}.so"

	dodoc-php AUTHORS ChangeLog INSTALL NEWS README README.KNOWN-ISSUES TODO2
}

pkg_postinst() {
	ewarn "Portage has not enabled this extension automatically!"
	ewarn "You must add the line: 'extension=php_gtk2.so' in the"
	ewarn "appropriate ini file, usually found in:"
	ewarn "/etc/php/cli-php/php.ini"
	epause
}
