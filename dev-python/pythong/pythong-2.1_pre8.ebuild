# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythong/pythong-2.1_pre8.ebuild,v 1.2 2003/09/06 23:32:28 msterret Exp $

inherit distutils

MY_PN="pythonG"
MY_PV=${PV/_/-}
MY_PV=${MY_PV/./_}

DESCRIPTION="Nice and powerful spanish development enviroment for Python"
SRC_URI="http://www3.uji.es/~dllorens/downloads/pythong/linux/${MY_PN}-${MY_PV}.tgz
	doc? ( http://marmota.act.uji.es/MTP/pdf/python.pdf )"
HOMEPAGE="http://www3.uji.es/~dllorens/PythonG/principal.html"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE="doc"

S=${WORKDIR}/${MY_PN}-${MY_PV}

RDEPEND=">=dev-lang/python-2.2.2
	>=dev-lang/tk-8.3.4
	>=dev-python/pmw-1.1"

pkg_setup() {
	distutils_python_tkinter
}

src_compile() {
	return
}

src_install() {

	distutils_python_version

	insinto /usr/lib/python${PYVER}/site-packages/
	doins modulepythong.py
	doins libpythong/fromidle.py

	exeinto /usr/bin
	doexe pythong.py

	dodoc leeme.txt
	cp -r ${S}/{LICENCIA,MANUAL,demos} ${D}/usr/share/doc/${PF}
	rm -f ${D}/usr/share/doc/${PF}/demos/modulepythong.py

	if [ -n "`use doc`" ]; then
		insinto /usr/share/doc/${PF}
		doins ${DISTDIR}/python.pdf
	fi

}
