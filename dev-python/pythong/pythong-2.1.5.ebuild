# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythong/pythong-2.1.5.ebuild,v 1.7 2005/03/23 14:34:58 blubb Exp $

inherit python distutils

MY_PN="pythonG"
MY_PV=${PV/_/-}
MY_PV=${MY_PV//\./_}

DESCRIPTION="Nice and powerful spanish development environment for Python"
SRC_URI="http://www3.uji.es/~dllorens/downloads/pythong/linux/${MY_PN}-${MY_PV}.tgz
	doc? ( http://marmota.act.uji.es/MTP/pdf/python.pdf )"
HOMEPAGE="http://www3.uji.es/~dllorens/PythonG/principal.html"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="doc"

S=${WORKDIR}/${MY_PN}-${MY_PV}

RDEPEND=">=dev-lang/python-2.2.2
	>=dev-lang/tk-8.3.4
	>=dev-python/pmw-1.2"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

PYTHON_MODNAME="libpythong"

pkg_setup() {
	python_tkinter_exists
}

src_compile() {
	return
}

src_install() {

	python_version

	sed -e  "s#^fullpath = .*#fullpath = '/usr/lib/python${PYVER}/site-packages/'#" \
		-i pythong.py

	insinto /usr/lib/python${PYVER}/site-packages/
	doins modulepythong.py
	dodir /usr/lib/python${PYVER}/site-packages/libpythong/
	cp -r ${S}/libpythong/* ${D}/usr/lib/python${PYVER}/site-packages/libpythong/

	exeinto /usr/bin
	doexe pythong.py

	dodoc leeme.txt
	cp -r ${S}/{LICENCIA,MANUAL,demos} ${D}/usr/share/doc/${PF}
	rm -f ${D}/usr/share/doc/${PF}/demos/modulepythong.py

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins ${DISTDIR}/python.pdf
	fi
}
