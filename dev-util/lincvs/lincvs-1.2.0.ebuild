# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-1.2.0.ebuild,v 1.8 2005/01/11 17:17:13 carlo Exp $

inherit eutils

DESCRIPTION="A Graphical CVS Client"
HOMEPAGE="http://www.lincvs.org/"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/LinCVS/${P}/${P}-0-generic-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="kde"

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
