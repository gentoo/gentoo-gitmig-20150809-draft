# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xsl-stylesheets/docbook-xsl-stylesheets-1.57.0.ebuild,v 1.5 2003/09/05 22:37:21 msterret Exp $

S=${WORKDIR}/docbook-xsl-${PV}
DESCRIPTION="XSL Stylesheets for Docbook"
SRC_URI="mirror://sourceforge/docbook/docbook-xsl-${PV}.tar.gz"
HOMEPAGE="http://www.oasis-open.org/docbook/"

DEPEND="dev-libs/libxml2"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="x86 hppa amd64"

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

	[ -e $CATALOG ] || /usr/bin/xmlcatalog --noout --create $CATALOG


	# I REALLY don't want to do this, but I see no other way.
	# We need to clean out the old entries, and this is the only way I can
	# guarantee it...  I will remove this once the next version is released.

	/usr/bin/xmlcatalog --noout --del \
		"/usr/share/sgml/docbook/xsl-stylesheets-1.52.2" $CATALOG

	/usr/bin/xmlcatalog --noout --add "rewriteSystem" \
		"http://docbook.sourceforge.net/release/xsl/${PV}" \
		"/usr/share/sgml/docbook/xsl-stylesheets-${PV}" $CATALOG
	/usr/bin/xmlcatalog --noout --add "rewriteURI" \
			"http://docbook.sourceforge.net/release/xsl/${PV}" \
			"/usr/share/sgml/docbook/xsl-stylesheets-${PV}" $CATALOG
	/usr/bin/xmlcatalog --noout --add "rewriteSystem" \
			"http://docbook.sourceforge.net/release/xsl/current" \
			"/usr/share/sgml/docbook/xsl-stylesheets-${PV}" $CATALOG
	/usr/bin/xmlcatalog --noout --add "rewriteURI" \
			"http://docbook.sourceforge.net/release/xsl/current" \
			"/usr/share/sgml/docbook/xsl-stylesheets-${PV}" $CATALOG

}

pkg_postrm() {
	CATALOG=/etc/xml/catalog

	# Let's clean up after ourselves.

	/usr/bin/xmlcatalog --noout --del \
		"/usr/share/sgml/docbook/xsl-stylesheets-${PV}" $CATALOG

}
