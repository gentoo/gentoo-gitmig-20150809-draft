# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gallery/gallery-1.5.1_rc2.ebuild,v 1.2 2005/08/21 17:33:40 rl03 Exp $

inherit webapp

MY_P=${P/_rc/-RC}

DESCRIPTION="Web based (PHP Script) photo album viewer/creator"
HOMEPAGE="http://gallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="imagemagick"

RDEPEND=">=net-www/apache-1.3.24-r1
	virtual/php
	>=media-gfx/jhead-1.6
	app-arch/unzip
	media-libs/jpeg
	>=media-libs/netpbm-9.12
	imagemagick? ( >=media-gfx/imagemagick-5.4.9.1-r1 )"

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
