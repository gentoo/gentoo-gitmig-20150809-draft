# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythong/pythong-2.1.4.ebuild,v 1.2 2004/03/28 11:55:22 kloeri Exp $

inherit python distutils

MY_PN="pythonG"
MY_PV=${PV/_/-}
MY_PV=$(echo $MY_PV | sed -e 's:\.:_:g')

DESCRIPTION="Nice and powerful spanish development enviroment for Python"
SRC_URI="http://www3.uji.es/~dllorens/downloads/pythong/linux/old/${MY_PN}-${MY_PV}.tgz
	doc? ( http://marmota.act.uji.es/MTP/pdf/python.pdf )"
HOMEPAGE="http://www3.uji.es/~dllorens/PythonG/principal.html"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE="doc"

S=${WORKDIR}/${MY_PN}-${MY_PV}

RDEPEND=">=dev-lang/python-2.2.2
	>=dev-lang/tk-8.3.4
	>=dev-python/pmw-1.2"

pkg_setup() {
	if ! python_mod_exists Tkinter; then
		eerror "You need to Tk support in Python to continue. Try running:"
		eerror "USE=\"tcltk\" emerge python"
		die "Missing Tkinter support"
	fi
}

src_compile() {
	return
}

src_install() {

	python_version

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
