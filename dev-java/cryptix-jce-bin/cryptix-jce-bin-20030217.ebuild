# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cryptix-jce-bin/cryptix-jce-bin-20030217.ebuild,v 1.2 2004/09/08 13:24:40 axxo Exp $

inherit java-pkg

DESCRIPTION="Cryptix JCE is a complete clean-room implementation of the official JCE 1.2 API as published by Sun."
SRC_URI="http://cryptix.org/dist/${P/-bin}-snap.zip"
HOMEPAGE="http://cryptix.org/"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2"

S=${WORKDIR}

src_compile() { :; }

src_install() {
	dodoc README.TXT ChangeLog.txt LICENCE.TXT
	java-pkg_dojar bin/*.jar
}
