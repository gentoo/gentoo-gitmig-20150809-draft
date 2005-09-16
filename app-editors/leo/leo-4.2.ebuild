# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leo/leo-4.2.ebuild,v 1.6 2005/09/16 03:06:41 mr_bones_ Exp $

inherit eutils python

MY_P=${P}-final
DESCRIPTION="Leo is an outlining editor and literate programming tool."
HOMEPAGE="http://leo.sourceforge.net/"
SRC_URI="mirror://sourceforge/leo/${MY_P}.zip"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="virtual/python
	dev-lang/tk"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}" || die "Failed to cd ${S}"
	epatch "${FILESDIR}"/leoConfig.py.patch
}

src_install() {
	python_version
	INST_DIR=/usr/lib/python${PYVER}/site-packages/leo
	dodoc ${S}/PKG-INFO MANIFEST doc/*
	rm -rf PKG-INFO MANIFEST doc/*
	dodir ${INST_DIR}
	cp -r * "${D}"/${INST_DIR}/ || die "cp failed"
	echo "#!/bin/bash" > leo
	echo "exec /usr/bin/python ${INST_DIR}/src/leo.py \"\$1\"" >> leo
	exeinto /usr/bin
	doexe leo || die "doexe failed"
}
