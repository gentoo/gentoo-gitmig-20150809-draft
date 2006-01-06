# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/esvn/esvn-0.6.11.ebuild,v 1.4 2006/01/06 15:03:32 mrness Exp $

inherit kde-functions

MY_P="${P}-1"
DESCRIPTION="GUI frontend to the Subversion revision system"
HOMEPAGE="http://esvn.umputun.com/"
SRC_URI="http://esvn.umputun.com/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="
	dev-util/subversion"

need-qt 3

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A} || die "failed to unpack sources"
	sed -i "s:qmake:${QTDIR}/bin/qmake:" ${S}/Makefile && \
		sed -i "s:/usr/share/doc/esvn/html-docs:/usr/share/doc/${PF}/html:" "${S}/src/mainwindow.cpp" || \
			die "at least one sed has failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make -f esvn.mak INSTALL_ROOT=${D} install
	dobin esvn esvn-diff-wrapper

	dodoc AUTHORS ChangeLog README
	dohtml -r html-docs/*
}
