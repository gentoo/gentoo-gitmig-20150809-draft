# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/esvn/esvn-0.6.8-r1.ebuild,v 1.1 2005/01/31 18:03:02 mrness Exp $

inherit kde-functions

MY_P="${P}-1"
DESCRIPTION="GUI frontend to the Subversion revision system"
HOMEPAGE="http://esvn.umputun.com/"
SRC_URI="http://esvn.umputun.com/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="
	dev-util/subversion"

need-qt 3

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A} || die "failed to unpack sources"
	sed -i "s:/usr/share/doc/esvn/html-docs:/usr/share/doc/${PF}/html:" "${S}/src/mainwindow.cpp" || \
		die "failed to replace doc path"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make -f esvn.mak INSTALL_ROOT=${D} install
	dobin esvn-diff-wrapper

	dodoc AUTHORS ChangeLog COPYING LICENSE README
	dohtml -r html-docs/*
}
