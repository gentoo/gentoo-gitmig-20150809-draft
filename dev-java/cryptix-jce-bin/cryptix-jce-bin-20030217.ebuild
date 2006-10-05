# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cryptix-jce-bin/cryptix-jce-bin-20030217.ebuild,v 1.8 2006/10/05 15:35:40 gustavoz Exp $

inherit java-pkg

DESCRIPTION="Cryptix JCE is a complete clean-room implementation of the official JCE 1.2 API as published by Sun."
SRC_URI="http://cryptix.org/dist/${P/-bin}-snap.zip"
HOMEPAGE="http://cryptix.org/"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.2"

S=${WORKDIR}

src_compile() { :; }

src_install() {
	dodoc README.TXT ChangeLog.txt
	java-pkg_dojar bin/*.jar
}
