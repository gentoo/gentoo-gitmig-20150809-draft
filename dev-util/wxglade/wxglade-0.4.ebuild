# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/wxglade/wxglade-0.4.ebuild,v 1.1 2006/04/21 04:48:51 halcy0n Exp $

inherit python

MY_P="wxGlade-${PV}"
DESCRIPTION="Glade-like GUI designer which can generate Python, Perl, C++ or XRC code"
HOMEPAGE="http://wxglade.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxglade/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
S="${WORKDIR}/${MY_P}"
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
	echo "exec python /usr/lib/python${PYVER}/site-packages/${PN}/wxglade.py \$*" >> wxglade
	exeinto /usr/bin
	doexe wxglade
}

