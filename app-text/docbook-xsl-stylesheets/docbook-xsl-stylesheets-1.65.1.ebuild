# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xsl-stylesheets/docbook-xsl-stylesheets-1.65.1.ebuild,v 1.1 2004/07/22 04:35:40 obz Exp $

S=${WORKDIR}/docbook-xsl-${PV}

DESCRIPTION="XSL Stylesheets for Docbook"
HOMEPAGE="http://docbook.sourceforge.net/"
SRC_URI="mirror://sourceforge/docbook/docbook-xsl-${PV}.tar.gz"
LICENSE="as-is | BSD"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~amd64 ~ia64"
IUSE=""

DEPEND="dev-libs/libxml2
	>=app-text/build-docbook-catalog-1.1"

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
	cp -af doc ${D}/usr/share/doc/${P}/html
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
