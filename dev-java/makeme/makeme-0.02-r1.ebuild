# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/makeme/makeme-0.02-r1.ebuild,v 1.6 2002/08/01 11:40:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Make utility written in Java"
SRC_URI="mirror://sourceforge/makeme/makeme-0.02.tar.gz"
HOMEPAGE="http://makeme.sf.net"

DEPEND=">=virtual/jdk-1.2
        >=dev-java/jikes-1.13
        >=dev-java/antlr-2.7.1-r1"
RDEPEND=">=virtual/jdk-1.2
	>=dev-java/antlr-2.7.1-r1"

src_unpack() {
	unpack makeme-0.02.tar.gz
    
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}
        
src_compile() {
	make build || die
}

src_install () {
	dodir usr/share/makeme
	dodir usr/bin
	insinto usr/share/makeme
	doins makeme.jar
	exeinto /usr/bin
	newexe ${FILESDIR}/makeme.sh makeme
	doman doc/makeme.1
	echo "/usr/share/makeme/makeme.jar" > ${D}/usr/share/makeme/classpath.env
}

