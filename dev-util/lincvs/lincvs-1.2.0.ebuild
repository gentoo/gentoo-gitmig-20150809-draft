# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-1.2.0.ebuild,v 1.5 2004/03/19 09:55:30 mr_bones_ Exp $

IUSE="kde"

DESCRIPTION="A Graphical CVS Client"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/LinCVS/${P}/${P}-0-generic-src.tgz"
HOMEPAGE="http://www.lincvs.org"

SLOT="0"
KEYWORDS="x86 ~sparc"
LICENSE="GPL-2"

DEPEND="kde? ( >=kde-base/kdelibs-2 )
	>=x11-libs/qt-3.0.5
	>=dev-util/cvs-1.9"

RDEPEND="${DEPEND}
	dev-util/cvs"

src_compile() {
	# Patch wrapper script
	epatch ${FILESDIR}/${P}-gentoo.diff

	qmake -o Makefile lincvs.pro
	sed -e "s/^\tstrip/#\tstrip/" -i Makefile

	addpredict ${QTDIR}/etc/settings

	emake || die "make failed"
	emake install || die "make install failed"
}

src_install () {
	mkdir -p ${D}/usr/share
	cp -pR ${S}/LinCVS ${D}/usr/share
	dobin ${S}/LinCVS/lincvs
}
