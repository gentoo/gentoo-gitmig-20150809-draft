# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gallery/gallery-2.2.3.ebuild,v 1.4 2007/09/07 18:21:54 wolf31o2 Exp $

inherit webapp eutils depend.php

DESCRIPTION="Web based (PHP Script) photo album viewer/creator"
HOMEPAGE="http://gallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-full.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 hppa ppc ~ppc64 ~sparc x86"
IUSE="dcraw ffmpeg gd imagemagick mysql netpbm postgres unzip zip"

RDEPEND="
	media-libs/jpeg
	dcraw? ( >=media-gfx/dcraw-8.03 )
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20051216 )
	gd? ( >=media-libs/gd-2 )
	imagemagick? ( >=media-gfx/imagemagick-5.4.9.1-r1 )
	netpbm? ( >=media-libs/netpbm-9.12 >=media-gfx/jhead-2.2 )
	unzip? ( app-arch/unzip )
	zip? ( app-arch/zip )
"

S=${WORKDIR}/${PN}2

need_php

pkg_setup() {
	webapp_pkg_setup

	local php_flags="pcre session"
	local DIE=

	use mysql && php_flags="${php_flags} mysql"
	use postgres && php_flags="${php_flags} postgres"

	if ! PHPCHECKNODIE="yes" require_php_with_use ${php_flags}; then
		DIE="yes"
	fi
	if use gd; then
		if ! PHPCHECKNODIE="yes" require_php_with_any_use gd gd-external ; then
			DIE="yes"
		fi
	fi

	if [[ ${DIE} == "yes" ]]; then
		eerror
		eerror "${PHP_PKG} needs to be re-installed with all of the following"
		eerror "USE flags enabled:"
		eerror
		eerror "${php_flags}"
		eerror
		if use gd; then
			eerror "as well as any of the following USE flags enabled:"
			eerror
			eerror "gd gd-external"
			eerror
		fi
		die "Re-install ${PHP_PKG}"
	fi
}

src_install() {
	webapp_src_preinst

	cp -R * ${D}/${MY_HTDOCSDIR}
	dohtml README.html

	webapp_postinst_txt en ${FILESDIR}/postinstall-en2.txt
	webapp_src_install
}

pkg_postinst() {
	elog "You are strongly encouraged to back up your database"
	elog "and the g2data directory, as upgrading to 2.2 will make"
	elog "irreversible changes to both."
	elog
	elog "g2data dir: cp -Rf /path/to/g2data/ /path/to/backup"
	elog "mysql: mysqldump --opt -u username -h hostname -p database > /path/to/backup.sql"
	elog "postgres: pg_dump -h hostname --format=t database > /path/to/backup.sql"
	webapp_pkg_postinst
}
