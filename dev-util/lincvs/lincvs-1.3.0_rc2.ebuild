# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-1.3.0_rc2.ebuild,v 1.2 2004/02/11 20:33:27 caleb Exp $

IUSE="kde"

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Graphical CVS Client"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/20_LinCVS/hr_${P/_/}/${MY_P}-generic-src.tgz"

HOMEPAGE="http://www.lincvs.org"

SLOT="0"
KEYWORDS="~x86 ~sparc"
LICENSE="GPL-2"
RESTRICT="nomirror"

DEPEND="kde? ( >=kde-base/kdelibs-3 )
	>=x11-libs/qt-3.0.5
	>=dev-util/cvs-1.11.10"

RDEPEND="${DEPEND}
	dev-util/cvs"

src_compile() {
	# Patch wrapper script
	epatch ${FILESDIR}/${MY_P}-gentoo.diff

	qmake -o Makefile lincvs.pro
	sed -i -e "s/^\tstrip/#\tstrip/" Makefile
	sed -i -e "s/CFLAGS   = -pipe -Wall -W -O2/CFLAGS   = ${CFLAGS} -Wall -W/" Makefile
	sed -i -e "s/CXXFLAGS = -pipe -Wall -W -O2/CXXFLAGS = ${CXXFLAGS} -Wall -W/" Makefile

	addpredict ${QTDIR}/etc/settings

	emake || die "make failed"
	emake install || die "make install failed"
}

src_install () {
	dodir /usr/share
	cd ${S}
	cp -pR LinCVS ${D}/usr/share
	dobin LinCVS/lincvs
	dodoc AUTHORS BUGS.txt ChangeLog COPYING LICENSE NEWS THANKS VERSION ./doc/*
}
