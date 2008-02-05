# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gallery/gallery-1.5.5.ebuild,v 1.4 2008/02/05 15:13:28 hollow Exp $

inherit webapp depend.apache

DESCRIPTION="Web based (PHP Script) photo album viewer/creator"
HOMEPAGE="http://gallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="imagemagick netpbm unzip zip"

RDEPEND="virtual/php
	media-libs/jpeg
	netpbm? ( >=media-libs/netpbm-9.12 >=media-gfx/jhead-2.2 )
	imagemagick? ( >=media-gfx/imagemagick-5.4.9.1-r1 )
	unzip? ( app-arch/unzip )
	zip? ( app-arch/zip )"

need_apache2

S=${WORKDIR}/${PN}

src_install() {
	webapp_src_preinst

	cp -R * ${D}/${MY_HTDOCSDIR}
	for file in AUTHORS ChangeLog README ChangeLog.archive.gz; do
		dodoc ${file}
		rm -f ${D}/${MY_HTDOCSDIR}/${file}
	done
	dohtml docs/*

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
