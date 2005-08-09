# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/jahshaka/jahshaka-2.0_rc1.ebuild,v 1.1 2005/08/09 14:21:10 zypher Exp $

inherit eutils

MY_P="${P/-2.0_rc/_2.0_RC}"
DESCRIPTION="The worlds first OpenSource Realtime Editing and Effects System."
HOMEPAGE="http://www.jahshaka.com"
SRC_URI="mirror://sourceforge/${PN}fx/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

DEPEND="virtual/x11
	media-video/avifile
	>=media-libs/glut-3.7.1
	>=media-libs/freetype-2.1.9
	=x11-libs/qt-3*"

RDEPEND=${DEPEND}

RESTRICT="nostrip"

S="${WORKDIR}/${PN}"

src_compile() {
	sed -e "s/qmake/\$\{QTDIR\}\/bin\/qmake/" -i ${S}/configure
	./configure --prefix=/usr \
	`use_enable static` \
	`use_enable debug` \
	|| die "configure failed"

	cd ${S}/plugins
	${QTDIR}/bin/qmake plugins.pro
	cd ${S}

	make || die
	cd ${S}/plugins
	make || die "plugins failed"
}

src_install() {

	cd ${S}
	make INSTALL_ROOT=${D} DESTDIR=${D} install || die
	dobin jahshaka

	# They do no harm but we don't like 'CVS' dirs in every subdir
	for i in $(ls -la -R * | grep CVS | grep / | cut -f1 -d:)
	do
	    rm -rf ${i}
	done

	dodir /usr/lib/jahshaka
	cp -a ${S}/source/OpenLibraries/lib/* ${D}/usr/lib/${PN}/
	cp -a --parent $(find plugins -iname *.so) ${D}usr/share/${PN}/
	cp -a --parent $(find plugins -iname *.fp) ${D}usr/share/${PN}/

	cp -a ${S}/database/JahDesktopDB.bak ${D}/usr/share/jahshaka/database/JahDesktopDB
	chmod 664 ${D}/usr/share/jahshaka/database/*

	dodir /etc/env.d
	echo "LDPATH=/usr/lib/"${PN} > ${D}etc/env.d/98${P}

	dodoc README AUTHORS TODO
}
