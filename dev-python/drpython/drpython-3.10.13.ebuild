# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/drpython/drpython-3.10.13.ebuild,v 1.4 2005/08/09 21:20:20 metalgod Exp $

inherit eutils distutils

DESCRIPTION="A powerful cross-platform IDE for Python"
HOMEPAGE="http://drpython.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=">=dev-python/wxpython-2.6"
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/drpython.py-${PV}.patch
}

src_install() {
	distutils_python_version

	local destdir="/usr/lib/python${PYVER}/site-packages/${PN}/"
	dodir  ${destdir}/bitmaps/{16,24}
	cp -R bitmaps ${D}/${destdir} || die "Failed to cp bitmaps"

	distutils_src_install

	#Windows-only setup script:
	rm ${D}/usr/bin/postinst.py

	echo -e "#!/bin/sh\n\npython ${destdir}/drpython.py \$@" > drpython
	dobin drpython
}

pkg_postinst() {
	einfo "See the DrPython homepage for 20+ available plugins:"
	einfo "http://sourceforge.net/project/showfiles.php?group_id=83074"
}

