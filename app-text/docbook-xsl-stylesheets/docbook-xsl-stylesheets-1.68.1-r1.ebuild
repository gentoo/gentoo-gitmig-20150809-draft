# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xsl-stylesheets/docbook-xsl-stylesheets-1.68.1-r1.ebuild,v 1.9 2005/08/23 04:04:04 agriffis Exp $

DESCRIPTION="XSL Stylesheets for Docbook"
HOMEPAGE="http://docbook.sourceforge.net/projects/xsl/index.html"
SRC_URI="mirror://sourceforge/docbook/docbook-xsl-${PV}.tar.bz2"

LICENSE="|| ( as-is BSD )"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="dev-libs/libxml2
	>=app-text/build-docbook-catalog-1.1"

S=${WORKDIR}/docbook-xsl-${PV}

src_install() {
	# Create the installation directory
	DEST="/usr/share/sgml/docbook/xsl-stylesheets-${PV}"
	dodir ${DEST}

	# The list of stylesheets we want to install
	local sheets="common eclipse extensions fo html htmlhelp images \
		javahelp lib manpages params profiling \
		template xhtml"

	for i in ${sheets}; do
		cd ${S}/${i}
		for doc in ChangeLog README; do
			if [ -e "$doc" ]; then
				mv ${doc} ${doc}.${i}
				dodoc ${doc}.${i}
				rm ${doc}.${i}
			fi
		done

		cd ${S}
		cp -af ${i} ${D}/${DEST}
	done

	# Install the documentation
	cd ${S}
	dodoc BUGS README RELEASE-NOTES.txt TODO WhatsNew
	dohtml -r doc/*
	cp VERSION ${D}/${DEST}
}

pkg_postinst() {
	build-docbook-catalog
}

pkg_postrm() {
	build-docbook-catalog
}
