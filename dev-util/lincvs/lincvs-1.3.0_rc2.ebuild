# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-1.3.0_rc2.ebuild,v 1.8 2005/01/11 17:17:13 carlo Exp $

inherit eutils

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Graphical CVS Client"
HOMEPAGE="http://www.lincvs.org/"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/20_LinCVS/hr_${P/_/}/${MY_P}-generic-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ppc ~amd64"
IUSE="kde"

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
