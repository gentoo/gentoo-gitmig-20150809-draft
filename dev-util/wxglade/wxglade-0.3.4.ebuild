# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/wxglade/wxglade-0.3.4.ebuild,v 1.3 2004/10/17 20:46:46 pythonhead Exp $

inherit python

MY_P="wxGlade-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Glade-like GUI designer which can generate Python, Perl, C++ or XRC code"
HOMEPAGE="http://wxglade.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxglade/${MY_P}.zip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND=">=dev-lang/python-2.2
	>=dev-python/wxpython-2.4.2.4"

src_install() {
	python_version
	dodir /usr/lib/python${PYVER}/site-packages/${PN}
	dodoc *txt
	cp credits.txt ${D}/usr/lib/python${PYVER}/site-packages/${PN}/
	dohtml -r docs/*
	rm -rf docs *txt
	cp -R * ${D}/usr/lib/python${PYVER}/site-packages/${PN}/
	dosym /usr/share/doc/${PF}/html /usr/lib/python${PYVER}/site-packages/${PN}/docs
	echo "#!/bin/bash" > wxglade
	echo "/usr/lib/python${PYVER}/site-packages/${PN}/wxglade.py \$*" >> wxglade
	exeinto /usr/bin
	doexe wxglade
}

