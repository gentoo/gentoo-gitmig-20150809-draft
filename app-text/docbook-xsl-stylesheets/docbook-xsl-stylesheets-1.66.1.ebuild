# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xsl-stylesheets/docbook-xsl-stylesheets-1.66.1.ebuild,v 1.1 2004/11/07 08:53:23 usata Exp $

DESCRIPTION="XSL Stylesheets for Docbook"
HOMEPAGE="http://docbook.sourceforge.net/"
SRC_URI="mirror://sourceforge/docbook/docbook-xsl-${PV}.tar.gz"

LICENSE="|| ( as-is BSD )"
SLOT="0"
KEYWORDS="~alpha ~arm ~amd64 ~hppa ~ia64 ~mips ~ppc ~s390 ~sparc ~x86 ~ppc64"
IUSE=""

DEPEND="dev-libs/libxml2
	>=app-text/build-docbook-catalog-1.1"

S=${WORKDIR}/docbook-xsl-${PV}

src_install() {
	# Create the installation directory
	DEST="/usr/share/sgml/docbook/xsl-stylesheets-${PV}"
	dodir ${DEST} /usr/share/doc/${P}

	# The list of stylesheets we want to install
	sheets="common extensions fo html htmlhelp images \
			   javahelp lib manpages params profiling \
			   template xhtml"
	for i in ${sheets}; do

		cd ${S}
		cp -af ${i} ${D}/${DEST}
		cd ${D}/${DEST}/${i}

		[ -e ChangeLog ] && \
			mv ChangeLog ${D}/usr/share/doc/${P}/ChangeLog.${i}
		[ -e README ] && \
			mv README ${D}/usr/share/doc/${P}/README.${i}

	done

	# Install the documentation
	cd ${S}
	dodoc BUGS TODO WhatsNew
	cp -af doc ${D}/usr/share/doc/${PF}/html
	cp VERSION ${D}/${DEST}

	# Only a few things in /usr/share/doc make sense to compress.
	# Everything else needs to be uncompressed to be useful. (bug 23048)
	find ${D}/usr/share/doc/${P} -name "ChangeLog" -exec gzip -f -9 \{\} \;
	gzip -f -9 ${D}/usr/share/doc/${P}/{README,ChangeLog}.*

}

pkg_postinst() {
	build-docbook-catalog
}

pkg_postrm() {
	build-docbook-catalog
}
