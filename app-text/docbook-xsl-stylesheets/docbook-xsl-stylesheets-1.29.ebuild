# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xsl-stylesheets/docbook-xsl-stylesheets-1.29.ebuild,v 1.1 2001/03/20 05:53:12 achim Exp $

A="dbx129.zip"
S=${WORKDIR}/docbook
DESCRIPTION="XSL Stylesheets for Docbook"
SRC_URI="http://www.nwalsh.com/docbook/xsl/${A}"

HOMEPAGE="http://www.oasis-open.org/docbook/"

DEPEND=">=app-arch/unzip-5.41"

src_install() {

   DEST="/usr/share/sgml/docbook/xsl-stylesheets-${PV}"
   dodir ${DEST}
   dodir /usr/share/doc/${P}
   cp -af doc ${D}/usr/share/doc/${P}/html
   cp VERSION ${D}/${DEST}
   for i in bin common contrib fo html images indexing lib template xhtml test
   do
	cd ${S}
	cp -af ${i} ${D}/${DEST} 
	cd ${D}/${DEST}/${i}
        for j in ChangeLog LostLog README
	do
	   if [ -e ${j} ]
	   then
		mv ${j} ${D}/usr/share/doc/${P}/${j}.${i} 
	   fi
	done
    done
    cd ${D}/${DEST}/test
    for i in *.xml
    do
      mv ${i} ${i}.orig
      sed -e "s:/share/doctypes/docbook/xml/:/usr/share/sgml/docbook/xml-dtd-4.1.2/:" ${i}.orig > ${i}
      rm ${i}.orig
    done
    prepalldocs
    cd ${S}
    dodoc BUGS TODO WhatsNew
}

