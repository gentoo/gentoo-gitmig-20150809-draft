# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/makeme/makeme-0.02.ebuild,v 1.4 2002/08/01 11:40:14 seemant Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Make utility written in Java"

SRC_URI="mirror://sourceforge/makeme/makeme-0.02.tar.gz"

HOMEPAGE="http://makeme.sf.net"

DEPEND=">=dev-java/blackdown-jre-1.3.1
        >=dev-java/jikes-1.13
        >=dev-java/antlr-2.7.1"

JAVA_HOME=/opt/blackdown-sdk-1.3.1/jre
PATH=$PATH:/opt/blackdown-sdk-1.3.1/bin
export DEFCLASSPATH=/opt/blackdown-sdk-1.3.1/jre/lib/rt.jar

src_unpack() {

    unpack makeme-0.02.tar.gz
    
    cd ${S}
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}
        
src_compile() {
    make build
}

src_install () {
    dodir usr/share/makeme
    dodir usr/bin
    insinto usr/share/makeme
    doins makeme.jar
    echo '#!/bin/bash' > ${D}/usr/bin/makeme
    echo "${JAVA_HOME}/bin/java -classpath \${CLASSPATH}:/usr/share/makeme/makeme.jar:/usr/share/antlr/antlrall.jar gnu.makeme.MakeMe \$@" \
    >> ${D}/usr/bin/makeme
    chmod a+x ${D}/usr/bin/makeme
    doman doc/makeme.1
}

