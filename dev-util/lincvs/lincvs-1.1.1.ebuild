# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-1.1.1.ebuild,v 1.1 2003/02/17 05:25:42 alain Exp $

IUSE="kde"

S=${WORKDIR}/${P}
DESCRIPTION="A Graphical CVS Client"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/LinCVS/${P}/${P}-0-generic-src.tgz"
HOMEPAGE="http://www.lincvs.org"

SLOT="0"
KEYWORDS="~x86 ~sparc"
LICENSE="GPL-2"

DEPEND="kde? ( >=kde-base/kdelibs-2 )
	>=x11-libs/qt-3.0.5
	>=cvs-1.9"

RDEPEND="${DEPEND}
	dev-util/cvs"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {

	qmake -o Makefile lincvs.pro
	sed -e "s/^\tstrip/#\tstrip/" -i Makefile
	make || die "make failed"
	make install || die "make install failed"
}

src_install () {
	mkdir -p ${D}/usr/share
	cp -pR ${S}/LinCVS ${D}/usr/share
	sed -e "s/^echo/#echo/" -i ${S}/LinCVS/lincvs
	echo "" >> ${S}/LinCVS/lincvs
	echo 'exec "/usr/share/LinCVS/AppRun" "$@"' >> ${S}/LinCVS/lincvs
	dobin ${S}/LinCVS/lincvs
}


