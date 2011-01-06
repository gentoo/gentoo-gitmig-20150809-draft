# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-libvirt/php-libvirt-9999.ebuild,v 1.1 2011/01/06 20:52:35 dev-zero Exp $

EAPI=3

PHP_EXT_NAME="libvirt"

inherit php-ext-source-r2 subversion

DESCRIPTION="PHP 5 bindings for libvirt."
HOMEPAGE="http://libvirt-debian.vm.antab.is/book.libvirt.html"
ESVN_REPO_URI="http://svn.antab.is/php-libvirt/trunk"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="<app-emulation/libvirt-0.8.6"
DEPEND="${DEPEND}
	>=dev-util/re2c-0.13.5
	dev-lang/php[cli]"

src_unpack() {
	subversion_src_unpack

	for slot in $(php_get_slots); do
		cp -r "${S}" "${WORKDIR}/${slot}"
	done
}

src_prepare() {
	php-ext-source-r2_src_prepare
}
