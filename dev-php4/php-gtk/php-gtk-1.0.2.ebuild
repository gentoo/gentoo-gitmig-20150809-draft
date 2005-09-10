# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/php-gtk/php-gtk-1.0.2.ebuild,v 1.1 2005/09/10 16:37:00 sebastian Exp $

PHP_EXT_NAME="php_gtk"
PHP_EXT_ZENDEXT="no"
PHPSAPILIST="cli" # we do NOT want it in place for apache[12],cgi
inherit php-ext-source-r1

DESCRIPTION="GTK+ bindings for PHP"
HOMEPAGE="http://gtk.php.net/"
SRC_URI="http://gtk.php.net/distributions/${P}.tar.gz"
S="${WORKDIR}/php_gtk-${PV}"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=""
RDEPEND="=x11-libs/gtk+-1.2*
	=gnome-base/libglade-0.17*"

# Fails to compile with higher MAKEOPTS
MAKEOPTS="-j1"

src_compile() {
	./buildconf

	#
	# pixbuf / canvas is missing
	#
	myconf="--enable-php-gtk=shared --enable-glade"

	php-ext-source-r1_src_compile
}

src_install() {
	php-ext-source-r1_src_install

	dodoc ChangeLog NEWS AUTHORS README TODO

	# examples
	docinto test/
	dodoc test/*
}

pkg_postinst () {
	einfo 'Check document test directory in documentation for some nice examples.'
}

need_php_by_category
