# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-gtk/php-gtk-1.0.0.ebuild,v 1.1 2003/12/02 16:21:58 latexer Exp $

PHP_EXT_NAME="php_gtk"
PHP_EXT_ZENDEXT="no"
inherit php-ext-source

DESCRIPTION="GTK bingings for php"
HOMEPAGE="http://gtk.php.net/"
SRC_URI="http://gtk.php.net/distributions/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="$DEPEND"

RDEPEND="=x11-libs/gtk+-1.2*"

# Fails to compile with higher MAKEOPTS
MAKEOPTS="-j1"

src_compile() {
	./buildconf

	#
	# pixbuf / canvas is missing
	#
	myconf="--enable-php-gtk=shared"

	php-ext-source_src_compile
}

src_install() {
	php-ext-source_src_install

	dodoc ChangeLog NEWS AUTHORS README TODO

	# examples
	docinto test/
	dodoc test/*
}

pkg_postinst () {
	einfo 'Check document test directory in documentation for some nice examples.'
}
