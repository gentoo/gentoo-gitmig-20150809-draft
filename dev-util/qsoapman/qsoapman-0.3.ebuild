# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qsoapman/qsoapman-0.3.ebuild,v 1.8 2007/01/19 15:16:50 masterdriverz Exp $

inherit qt3

IUSE=""

DESCRIPTION="Qt SOAP Manager is a GUI tool for sending SOAP messages."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://qsoapman.sourceforge.net/"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"

DEPEND="$(qt_min_version 3.1)"

RDEPEND="${DEPEND}"

src_compile() {
	${QTDIR}/bin/qmake -o Makefile qsoapman.pro
	sed -i -e "s/CFLAGS   = -pipe -Wall -W -O2/CFLAGS   = ${CFLAGS} -Wall -W/" src/Makefile
	sed -i -e "s/CXXFLAGS = -pipe -Wall -W -O2/CXXFLAGS = ${CXXFLAGS} -Wall -W/" src/Makefile

	addpredict ${QTDIR}/etc/settings

	emake || die "make failed"
	emake install || die "make install failed"
}

src_install () {
	insinto /usr/share/${PN}
	doins *.xml
	dobin bin/qsoapman
	dodoc AUTHORS BUGS ChangeLog COPYING TODO
}
