# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xsl-stylesheets/docbook-xsl-stylesheets-1.62.0-r1.ebuild,v 1.2 2004/01/13 14:32:25 gustavoz Exp $

S=${WORKDIR}/docbook-xsl-${PV}
DESCRIPTION="XSL Stylesheets for Docbook"
SRC_URI="mirror://sourceforge/docbook/docbook-xsl-${PV}.tar.gz"
HOMEPAGE="http://www.oasis-open.org/docbook/"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="x86 ~ia64 ~ppc ~hppa ~amd64 sparc"
IUSE=""

DEPEND="dev-libs/libxml2"

src_install() {
	DEST="/usr/share/sgml/docbook/xsl-stylesheets-${PV}"
	dodir ${DEST} /usr/share/doc/${P}

	cp -af doc ${D}/usr/share/doc/${P}/html
	cp VERSION ${D}/${DEST}

	for i in common extensions fo html htmlhelp images javahelp lib manpages template xhtml
	do
		cd ${S}
		cp -af ${i} ${D}/${DEST}
		cd ${D}/${DEST}/${i}

		for j in ChangeLog README
		do
			if [ -e ${j} ]
			then
				mv ${j} ${D}/usr/share/doc/${P}/${j}.${i}
	   		fi
		done
	done

	cd ${S}
	dodoc BUGS TODO WhatsNew

	# Only a few things in /usr/share/doc make sense to compress.
	# Everything else needs to be uncompressed to be useful. (bug 23048)
	find ${D}/usr/share/doc/${P} -name "ChangeLog" -exec gzip -f -9 \{\} \;
	gzip -f -9 ${D}/usr/share/doc/${P}/{README,ChangeLog}.*

	dodir /etc/xml
}

pkg_postinst() {
	CATALOG=/etc/xml/catalog

	[ -e $CATALOG ] || /usr/bin/xmlcatalog --noout --create $CATALOG

	# Ok, so the next version is out and we still have to manually delete them.
	# I'm working on an xml-catalog eclass.  When that's ready, we'll use it.

	/usr/bin/xmlcatalog --noout --del \
		"/usr/share/sgml/docbook/xsl-stylesheets-1.52.2" $CATALOG
	/usr/bin/xmlcatalog --noout --del \
		"/usr/share/sgml/docbook/xsl-stylesheets-1.57.0" $CATALOG
	/usr/bin/xmlcatalog --noout --del \
		"/usr/share/sgml/docbook/xsl-stylesheets-1.59.1" $CATALOG
	/usr/bin/xmlcatalog --noout --del \
		"/usr/share/sgml/docbook/xsl-stylesheets-1.59.2" $CATALOG
	/usr/bin/xmlcatalog --noout --del \
		"/usr/share/sgml/docbook/xsl-stylesheets-1.60.1" $CATALOG

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
