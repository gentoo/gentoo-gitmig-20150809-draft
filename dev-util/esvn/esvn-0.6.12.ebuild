# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/esvn/esvn-0.6.12.ebuild,v 1.7 2009/12/28 16:48:39 ssuominen Exp $

EAPI=2
inherit qt3

MY_P=${P}-1

DESCRIPTION="GUI frontend to the Subversion revision system"
HOMEPAGE="http://sourceforge.net/projects/esvn/"
SRC_URI="mirror://sourceforge/esvn/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""

DEPEND="x11-libs/qt:3"
RDEPEND="${DEPEND}
	dev-util/subversion"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i \
		-e "s:qmake:${QTDIR}/bin/qmake:" \
		Makefile || die
	sed -i \
		-e "s:/usr/share/doc/esvn/html-docs:/usr/share/doc/${PF}/html:" \
		src/mainwindow.cpp || die
}

src_install() {
	emake -f esvn.mak INSTALL_ROOT="${D}" install || die
	dobin esvn esvn-diff-wrapper || die

	dodoc AUTHORS ChangeLog README
	dohtml -r html-docs/*
}
