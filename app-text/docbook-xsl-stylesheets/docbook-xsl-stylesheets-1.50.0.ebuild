# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xsl-stylesheets/docbook-xsl-stylesheets-1.50.0.ebuild,v 1.5 2002/08/02 17:42:49 phoenix Exp $

S=${WORKDIR}/docbook-xsl-${PV}
DESCRIPTION="XSL Stylesheets for Docbook"
SRC_URI="mirror://sourceforge/docbook/docbook-xsl-${PV}.tar.gz"
HOMEPAGE="http://www.oasis-open.org/docbook/"
SLOT="0"
LICENSE="X11"

DEPEND="dev-libs/libxml2"
KEYWORDS="x86 ppc"
src_install() {
	DEST="/usr/share/sgml/docbook/xsl-stylesheets-${PV}"
	dodir ${DEST}
	dodir /usr/share/doc/${P}
	cp -af doc ${D}/usr/share/doc/${P}/html
	cp VERSION ${D}/${DEST}

	for i in common extensions fo html htmlhelp images javahelp lib template xhtml
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

	prepalldocs
	cd ${S}
	dodoc BUGS TODO WhatsNew

	dodir /etc/xml
}

pkg_postinst() {
	CATALOG=/etc/xml/catalog

	[ -e $CATALOG ] && rm $CATALOG

	/usr/bin/xmlcatalog --noout --create $CATALOG
	
	/usr/bin/xmlcatalog --noout --add "rewriteSystem" \
		"http://docbook.sourceforge.net/release/xsl/1.45" \
		"/usr/share/sgml/docbook/xsl-stylesheets-${PV}" $CATALOG
	/usr/bin/xmlcatalog --noout --add "rewriteURI" \
			"http://docbook.sourceforge.net/release/xsl/1.45" \
			"/usr/share/sgml/docbook/xsl-stylesheets-${PV}" $CATALOG
	/usr/bin/xmlcatalog --noout --add "rewriteSystem" \
			"http://docbook.sourceforge.net/release/xsl/current" \
			"/usr/share/sgml/docbook/xsl-stylesheets-${PV}" $CATALOG
	/usr/bin/xmlcatalog --noout --add "rewriteURI" \
			"http://docbook.sourceforge.net/release/xsl/current" \
			"/usr/share/sgml/docbook/xsl-stylesheets-${PV}" $CATALOG

}
