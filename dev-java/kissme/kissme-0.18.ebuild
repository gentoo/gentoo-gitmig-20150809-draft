# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/kissme/kissme-0.18.ebuild,v 1.1 2001/09/27 21:39:34 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Tiny JVM"

SRC_URI="http://prdownloads.sourceforge.net/kissme/kissme-0.18.tar.gz"

HOMEPAGE="http://kissme.sf.net"

DEPEND=">=dev-java/blackdown-sdk-1.3.1
        >=dev-java/makeme-0.02
        >=dev-libs/gmp-3.1.1
        =dev-java/kissme-classpath-0.18"

JAVA_HOME=/opt/blackdown-jre-1.3.1/jre

src_compile() {

    makeme
}

src_install () {

#    cd dist_classpath ; ./install.sh 
    dodoc AUTHORS COPYING NEWS
    dodoc doc/*.txt
    dodir usr/share/doc/${P}/html
    dodoc doc/{TAGS,TIMING}
    cp doc/*.html ${D}/usr/share/doc/${P}/html/
    dobin kissme
}

pkg_postinst() {

    echo " #"
    echo " Please remember to add /usr/share/kissme/classpath to your CLASSPATH"
    echo ' Example: export CLASSPATH=/usr/share/kissme/classpath:$CLASSPATH'
    echo " #"
}
