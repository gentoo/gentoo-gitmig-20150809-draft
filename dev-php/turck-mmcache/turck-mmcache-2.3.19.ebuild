# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/turck-mmcache/turck-mmcache-2.3.19.ebuild,v 1.4 2003/07/20 13:31:55 stuart Exp $

DESCRIPTION="Turck MMCache is a free open source PHP accelerator, optimizer, encoder and dynamic content cache for PHP. It increases performance of PHP scripts by caching them in compiled state, so that the overhead of compiling is almost completely eliminated. Also it uses some optimizations to speed up execution of PHP scripts. Turck MMCache typically reduces server load and increases the speed of your PHP code by 1-10 times."
SRC_URI="mirror://sourceforge/turck-mmcache/${P}.tar.gz"
HOMEPAGE="http://turck-mmcache.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

PHP_EXT_NAME="mmcache"
PHP_EXT_ZENDEXT="yes"

inherit php-ext

src_compile() {
	myconf="--enable-mmcache=shared"
	php-ext_src_compile
}

src_install() {
	
	php-ext_src_install

	# create Cache dir if it does not exist
	#
	# settings should ensure that cached files are secure,
	# *but* this may break php-cli
	#
	# please file a bug in http://bugs.gentoo.org if this happens
	# for you

	dodir /var/cache/mmcache
	fowner root.root /var/cache/mmcache
	fperms 1777 /var/cache/mmcache

    insinto /usr/share/${PN}
	doins encoder.php mmcache.php mmcache.gif
	
	dodoc CREDITS LICENSE README TODO EXPERIMENTAL
}

pkg_postinst () {
	php-ext_pkg_postinst

	php-ext_addtoinifiles "mmcache.shm_size" '"16"'
	php-ext_addtoinifiles "mmcache.cache_dir" '"/var/cache/mmcache"'
	php-ext_addtoinifiles "mmcache.enable" '"1"'
	php-ext_addtoinifiles "mmcache.optimizer" '"1"'
	php-ext_addtoinifiles "mmcache.check_mtime" '"1"'
	php-ext_addtoinifiles "mmcache.debug" '"0"'
	php-ext_addtoinifiles "mmcache.filter" '""'
	php-ext_addtoinifiles "mmcache.shm_max" '"0"'
	php-ext_addtoinifiles "mmcache.shm_ttl" '"0"'
	php-ext_addtoinifiles "mmcache.shm_prune_period" '"0"'

	einfo "You need to restart apache to activate MMCache"
	einfo
	einfo 'A web interface is available to manage the turck cache.'
	einfo 'Copy /usr/share/turck-mmcache/mmcache.php to somewhere'
	einfo 'where your web server can see it.'
	einfo
	einfo 'A PHP script encoder is available to encode your PHP scripts.'
	einfo 'The encoder is available as /usr/share/turck-mmcache/encoder.php'
	einfo 'The encoded file format is not yet considered stable'
}
