# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leo/leo-4.2.ebuild,v 1.1 2004/12/02 05:40:50 pythonhead Exp $

inherit eutils python

MY_P=${P}-final
DESCRIPTION="Leo is an outlining editor and literate programming tool."
HOMEPAGE="http://leo.sourceforge.net/"
SRC_URI="mirror://sourceforge/leo/${MY_P}.zip"
LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/python
	dev-lang/tk"
S=${WORKDIR}/${MY_P}


src_unpack() {
	unpack ${A} || die "Failed to unpack ${A}"
	cd ${S} || die "Failed to cd ${S}"
	epatch ${FILESDIR}/leoConfig.py.patch || \
		die "epatch failed on leoConfig.py.patch"
}

src_install() {
	python_version
	INST_DIR=/usr/lib/python${PYVER}/site-packages/leo
	dodir ${INST_DIR}
	dodir /usr/bin
	dodoc ${S}/PKG-INFO MANIFEST doc/*
	rm -rf PKG-INFO MANIFEST doc/*
	cp -r * ${D}/${INST_DIR}/
	echo "#!/bin/bash" > leo
	echo "exec /usr/bin/python ${INST_DIR}/src/leo.py \"\$1\"" >> leo
	exeinto /usr/bin
	doexe leo
}
