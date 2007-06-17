# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-gtk/php-gtk-2.0.0_beta.ebuild,v 1.1 2007/06/17 04:48:37 anant Exp $

PHP_EXT_NAME="php_gtk2"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP 5 bindings for the Gtk+ 2 library."
HOMEPAGE="http://gtk.php.net/"
SRC_URI="http://gtk.php.net/distributions/${PN}-${PV/_beta/}beta.tar.gz"

LICENSE="PHP"
SLOT="0"
IUSE="extra html libsexy mozembed sourceview spell scintilla debug nolibglade"

RDEPEND=">=dev-lang/php-5.1.2
	>=x11-libs/gtk+-2.6.0
	>=dev-libs/glib-2.6.0
	>=x11-libs/pango-1.8.0
	>=dev-libs/atk-1.6.0
	!nolibglade? ( >=gnome-base/libglade-2.5.0 )
	extra? ( >=x11-libs/gtk+extra-2.1.1 )
	html? ( >=gnome-extra/gtkhtml-3.10.0 )
	libsexy? ( >=x11-libs/libsexy-0.1.10 )
	mozembed? ( >=www-client/mozilla-firefox-1.5.0 )
	sourceview? ( >=x11-libs/gtksourceview-1.2.0 )
	spell? ( >=app-text/gtkspell-2.0.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

S="${WORKDIR}/${PN}-${PV/_beta/}beta"

pkg_setup() {
	has_php
	require_php_cli
	if use debug ; then
		require_php_with_use cli pcre debug
	else
		if has_debug ; then
			# PHP has debug enabled, but PHP-GTK doesn't!
			eerror "Please enable the 'debug' USE flag in"
			eerror "PHP-GTK, this is needed to work with"
			eerror "the debug version of PHP."
			die "Enable 'debug' USE flag"
		fi
		require_php_with_use cli pcre
	fi
}

src_compile() {
	# we already check for CLI
	# in-built check creates troubke on suhosin
	# based installations, so remove it
	epatch ${FILESDIR}/no-cli-check.patch

	if use nolibglade ; then
		GLCONF=" --disable-libglade"
	else
		GLCONF=""
	fi

	# php-ext-source-r1_src_compile can't be used
	has_php
	addpredict /usr/share/snmp/mibs/.index
	addpredict /session_mm_cli0.sem
	./buildconf

	econf $(use_with extra) \
		$(use_with html) \
		$(use_with libsexy) \
		$(use_with mozembed) \
		$(use_with sourceview) \
		$(use_with spell) \
		$(use_with debug) \
		$(use_enable scintilla) \
		${GLCONF} || die "configure failed!"
	emake || die "make failed!"
	mv -f "modules/${PHP_EXT_NAME}.so" "${WORKDIR}/${PHP_EXT_NAME}-default.so" || die "Unable to move extension"
}

src_install() {
	# can't use php-ext-source-r1_src_install
	# since it adds ini to apache2 too!
	# concurrentmodphp not applicable
	has_php
	addpredict /usr/share/snmp/mibs/.index

	insinto "${EXT_DIR}"
	newins "${WORKDIR}/${PHP_EXT_NAME}-default.so" "${PHP_EXT_NAME}.so"

	if [[ -f "/etc/php/cli-php${PHP_VERSION}/php.ini" ]] ; then
		inifile="etc/php/cli-php${PHP_VERSION}/ext/${PHP_EXT_NAME}.ini"
		inidir="${inifile/${PHP_EXT_NAME}.ini/}"
		inidir="${inidir/ext/ext-active}"
		dodir "/${inidir}"
		dosym "/${inifile}" "/${inifile/ext/ext-active}"
	fi
	php-ext-base-r1_addtoinifile "extension" "${PHP_EXT_NAME}.so" "${inifile}" "Extension added"

	dodoc-php AUTHORS ChangeLog INSTALL NEWS README README.KNOWN-ISSUES TODO2
}
