# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/qcad/qcad-2.0.1.0.ebuild,v 1.5 2004/02/10 07:36:29 phosphan Exp $

inherit kde-functions

MY_P=${P}-1.src
S=${WORKDIR}/${MY_P}
DESCRIPTION="A 2D CAD package based upon Qt."
SRC_URI="http://www.ribbonsoft.com/archives/qcad/${MY_P}.tar.gz"
HOMEPAGE="http://www.ribbonsoft.com/qcad.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

need-qt 3

DEPEND="${DEPEND}
		>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${MY_P}-gentoo.patch
	cd ${S}/scripts
	sed -i -e 's/^make/make ${MAKEOPTS}/' build_qcad.sh
	sed -i -e 's/^\.\/configure/.\/configure --host=${CHOST}/' build_qcad.sh
	# 2.0.1.0 sets QTDIR, I guess by accident
	sed -i -e 's:^export QTDIR=.*::' build_qcad.sh
}


src_compile() {
	cd scripts
	sh build_qcad.sh || die "build failed"
}

src_install () {
	cd qcad
	mv qcad qcad.bin
	dobin qcad.bin
	echo -e "#!/bin/sh\ncd /usr/share/${P}\nqcad.bin" > qcad
	chmod ugo+rx qcad
	dobin qcad
	dodir /usr/share/${P}
	cp -a patterns examples fonts scripts qm ${D}/usr/share/${P}
	cd ..
	dodoc README
}

