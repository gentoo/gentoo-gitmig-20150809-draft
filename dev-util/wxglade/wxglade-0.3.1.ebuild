# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/wxglade/wxglade-0.3.1.ebuild,v 1.1 2003/11/22 19:52:29 pythonhead Exp $

S="${WORKDIR}/wxGlade-${PV}"
DESCRIPTION="Glade-like GUI designer which can generate Python C++ and XRC code"
HOMEPAGE="http://wxglade.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxglade/wxGlade-${PV}.tgz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-python/wxPython-2.4.2.4"

src_install() {
	PY_VER=`python -c 'import sys;print sys.version[0:3]'`
	dodir /usr/lib/python${PY_VER}/site-packages/${PN}
	dodoc *txt
	cp credits.txt ${D}/usr/lib/python${PY_VER}/site-packages/${PN}
	rm *txt
	dohtml -r docs/*
	rm -rf docs
	mv examples ${D}/usr/share/doc/${PF}
	cp -R * ${D}/usr/lib/python${PY_VER}/site-packages/${PN}
	echo "#!/bin/bash" > wxglade
	echo "/usr/lib/python${PY_VER}/site-packages/${PN}/wxglade.py" >> wxglade
	exeinto /usr/bin
	doexe wxglade

}

