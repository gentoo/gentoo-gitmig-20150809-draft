# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gallery/gallery-1.4.4_p1.ebuild,v 1.2 2004/08/30 19:19:21 rl03 Exp $

inherit webapp eutils

MY_P=${P/_p/-pl}
DESCRIPTION="Web based (PHP Script) photo album viewer/creator."
HOMEPAGE="http://gallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86 ppc sparc alpha hppa ~amd64"
RDEPEND=">=net-www/apache-1.3.24-r1
	>=dev-php/mod_php-4.1.2-r5
	>=media-gfx/jhead-1.6
	>=media-libs/netpbm-9.12
	>=media-gfx/imagemagick-5.4.9.1-r1"

S=${WORKDIR}/${PN}

src_install() {
	webapp_src_preinst

	for file in AUTHORS ChangeLog README ChangeLog.archive.gz; do
		dodoc ${file}
		rm -f ${file}
	done

	cp -R . ${D}/${MY_HTDOCSDIR}
	dodir ${MY_HTDOCSDIR}/albums
	webapp_serverowned ${MY_HTDOCSDIR}/albums

	dohtml docs/*
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
