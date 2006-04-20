# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gallery/gallery-2.1.1a.ebuild,v 1.1 2006/04/20 17:34:34 rl03 Exp $

inherit webapp eutils

DESCRIPTION="Web based (PHP Script) photo album viewer/creator"
HOMEPAGE="http://gallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-full.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="ffmpeg gd imagemagick netpbm mysql postgres unzip zip"

RDEPEND="virtual/httpd-php
	media-libs/jpeg
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20051216 )
	gd? ( >=media-libs/gd-2 )
	imagemagick? ( >=media-gfx/imagemagick-5.4.9.1-r1 )
	netpbm? ( >=media-libs/netpbm-9.12 >=media-gfx/jhead-2.2 )
	mysql? ( dev-db/mysql )
	postgres? ( >=dev-db/postgresql-7 )
	unzip? ( app-arch/unzip )
	zip? ( app-arch/zip )
"

S=${WORKDIR}/${PN}2

src_install() {
	webapp_src_preinst

	cp -R * ${D}/${MY_HTDOCSDIR}
	dohtml README.html

	webapp_postinst_txt en ${FILESDIR}/postinstall-en2.txt
	webapp_src_install
}

pkg_postinst() {
	einfo "You are strongly encouraged to back up your database"
	einfo "and the g2data directory, as upgrading to 2.1.x will make"
	einfo "irreversible changes to both."
	einfo
	einfo "g2data dir: cp -Rf /path/to/g2data/ /path/to/backup"
	einfo "mysql: mysqldump --opt -u username -h hostname -p database > /path/to/backup.sql"
	einfo "postgres: pg_dump -h hostname --format=t database > /path/to/backup.sql"
	webapp_pkg_postinst
}
