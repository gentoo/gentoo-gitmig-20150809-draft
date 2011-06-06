# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/libvirt-php/libvirt-php-9999.ebuild,v 1.3 2011/06/06 15:09:40 halcy0n Exp $

EAPI=3

PHP_EXT_NAME="php-libvirt"
USE_PHP="php5-3 php5-2"

inherit php-ext-source-r2 git eutils

DESCRIPTION="PHP 5 bindings for libvirt."
HOMEPAGE="http://libvirt.org/php.html"
EGIT_REPO_URI="git://libvirt.org/libvirt-php.git"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="app-emulation/libvirt
	dev-libs/libxml2"
DEPEND="${DEPEND}
	doc? ( app-text/xhtml1 dev-libs/libxslt )"

src_unpack() {
	git_src_unpack
	# create the default modules directory to be able
	# to use the php-ext-source-r2 eclass to install
	ln -s src "${S}/modules"

	for slot in $(php_get_slots); do
		cp -r "${S}" "${WORKDIR}/${slot}"
	done
}

src_prepare() {
	php-ext-source-r2_src_prepare
}

src_install() {
	php-ext-source-r2_src_install
	use doc && dohtml docs/* docs/graphics/*
}
