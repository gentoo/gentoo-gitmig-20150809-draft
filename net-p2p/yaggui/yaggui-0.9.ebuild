# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/yaggui/yaggui-0.9.ebuild,v 1.2 2004/09/03 17:30:32 dholm Exp $

inherit java-pkg

DESCRIPTION="Yet Another Gift GUI in java"
HOMEPAGE="http://yaggui.sourceforge.net/"
SRC_URI="mirror://sourceforge/yaggui/${P/y/Y}-src.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-java/ant-1.4"
RDEPEND=">=virtual/jdk-1.4
	virtual/x11"
S=${WORKDIR}/${P}-src

src_compile() {
	ant build-jar || die
}

src_install() {
	java-pkg_dojar build/Yaggui.jar
	dohtml docs/*
	exeinto /usr/bin
	newexe ${FILESDIR}/${PN}.sh ${PN}
}
