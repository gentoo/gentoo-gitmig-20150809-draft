# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythong/pythong-2.0.21.2.ebuild,v 1.6 2003/09/06 23:32:28 msterret Exp $

inherit distutils

MY_PN="pythonG"
# 3rd version number = u = 21st alphabet in english
# this package has a weird versioning scheme.
MY_PV="2_0u_2"

DESCRIPTION="Nice and powerful spanish development enviroment for Python"
HOMEPAGE="http://www3.uji.es/~dllorens/PythonG/principal.html"
SRC_URI="http://www.colicsoft.com/pub/${MY_PN}-${MY_PV}.tgz
	doc? ( http://marmota.act.uji.es/MTP/pdf/python.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="doc"

RDEPEND=">=dev-lang/python-2.2.2
	>=dev-lang/tk-8.3.4
	>=dev-python/pmw-1.1"

S=${WORKDIR}/${MY_PN}-${MY_PV}

pkg_setup() {
	if ! python -c "import Tkinter" >/dev/null 2>&1
	then
		eerror "You need to recompile python with Tkinter support."
		eerror "That means: USE='tcltk' emerge python"
		echo
		die "missing tkinter support with installed python"
	fi
}

src_compile() {
	echo -n
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
