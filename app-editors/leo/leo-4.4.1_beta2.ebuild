# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leo/leo-4.4.1_beta2.ebuild,v 1.1 2006/06/25 21:46:40 lucass Exp $

inherit eutils python

MY_P="${PN}-4-4-1-beta-2"
DESCRIPTION="Leo is an outlining editor and literate programming tool."
HOMEPAGE="http://leo.sourceforge.net/"
SRC_URI="mirror://sourceforge/leo/${MY_P}.zip"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/python
	dev-lang/tk"

DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/leoGlobals-${PV}.patch"
}

src_install() {
	dodir /usr/share/doc/
	mv doc "${D}/usr/share/doc/${PF}"
	rm PKG-INFO MANIFEST install manifest.in uninstall

	python_version
	destdir="/usr/$(get_libdir)/python${PYVER}/site-packages/leo"
	dodir "${destdir}"
	cp -r * "${D}/${destdir}" || die "cp failed"

	echo "#!/bin/bash" > leo
	echo "exec ${python} ${destdir}/src/leo.py \"\$1\"" >> leo
	exeinto /usr/bin
	doexe leo || die "doexe failed"
}
