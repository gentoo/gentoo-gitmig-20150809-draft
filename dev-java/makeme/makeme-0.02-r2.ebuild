# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/makeme/makeme-0.02-r2.ebuild,v 1.1 2003/05/24 04:21:00 absinthe Exp $

inherit java-pkg

S=${WORKDIR}/${P}
DESCRIPTION="Make utility written in Java"
SRC_URI="mirror://sourceforge/makeme/makeme-0.02.tar.gz"
HOMEPAGE="http://makeme.sf.net"
DEPEND=">=dev-java/jikes-1.13
        >=dev-java/antlr-2.7.1-r1"
RDEPEND=">=virtual/jdk-1.2
		>=dev-java/antlr-2.7.1-r1"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

src_unpack() {
	unpack makeme-0.02.tar.gz
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}
        
src_compile() {
	make build || die "Compile failed"
	make install || die "Create Jar failed"
}

src_install () {
	java-pkg_dojar makeme.jar
	cp ${FILESDIR}/makeme.sh ${S}/makeme
	dobin ${S}/makeme
	doman doc/makeme.1
}
