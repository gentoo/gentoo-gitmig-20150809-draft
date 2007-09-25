# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/esvn/esvn-0.6.12.ebuild,v 1.2 2007/09/25 21:06:57 mrness Exp $

inherit kde-functions

MY_P="${P}-1"
DESCRIPTION="GUI frontend to the Subversion revision system"
HOMEPAGE="http://zoneit.free.fr/esvn/"
SRC_URI="http://zoneit.free.fr/esvn/${MY_P}.tar.gz
	mirror://sourceforge/esvn/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-util/subversion"

need-qt 3

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}

	sed -i "s:qmake:${QTDIR}/bin/qmake:" "${S}"/Makefile && \
		sed -i "s:/usr/share/doc/esvn/html-docs:/usr/share/doc/${PF}/html:" "${S}"/src/mainwindow.cpp || \
			die "at least one sed has failed"
}

src_install() {
	emake -f esvn.mak INSTALL_ROOT="${D}" install || die "emake install failed"
	dobin esvn esvn-diff-wrapper || die "failed to install bin files"

	dodoc AUTHORS ChangeLog README
	dohtml -r html-docs/*
}
