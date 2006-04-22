# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/php-gtk/php-gtk-1.0.2.ebuild,v 1.6 2006/04/22 13:15:33 voxus Exp $

PHP_EXT_NAME="php_gtk"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

KEYWORDS="~amd64 ~ppc ~x86"
DESCRIPTION="GTK+ bindings for PHP."
HOMEPAGE="http://gtk.php.net/"
SRC_URI="http://gtk.php.net/distributions/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

S="${WORKDIR}/php_gtk-${PV}"

RDEPEND="=x11-libs/gtk+-1.2*
		=gnome-base/libglade-0.17*"

need_php_by_category

# Fails to compile with higher MAKEOPTS
MAKEOPTS="-j1"

pkg_setup() {
	has_php

	require_php_with_use cli pcre session
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	# patch to fix bug #90570
	epatch "${FILESDIR}/undef-gtk_shpaned_new.patch"
}

src_compile() {
	has_php

	./buildconf

	#
	# pixbuf / canvas is missing
	#
	myconf="--enable-php-gtk=shared --enable-glade"

	php-ext-source-r1_src_compile
}

src_install() {
	php-ext-source-r1_src_install

	dodoc-php ChangeLog NEWS AUTHORS README TODO

	# examples
	dodoc-php `find test/ -type f -print`
}

pkg_postinst() {
	einfo "Check document test directory in documentation for some nice examples."
}
