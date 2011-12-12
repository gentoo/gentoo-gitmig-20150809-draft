# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docx2txt/docx2txt-1.1.ebuild,v 1.1 2011/12/12 23:02:38 radhermit Exp $

EAPI=4

inherit eutils

DESCRIPTION="Convert MS Office docx files to plain text"
HOMEPAGE="http://docx2txt.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-arch/unzip
	dev-lang/perl"

src_prepare() {
	epatch "${FILESDIR}"/${P}-paragraph-newline.patch
}

src_compile() { :; }

src_install() {
	newbin docx2txt.pl docx2txt
	dodoc docx2txt.config README ChangeLog ToDo AUTHORS
}
