# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xsl-stylesheets/docbook-xsl-stylesheets-1.69.1.ebuild,v 1.5 2006/04/05 23:44:05 flameeyes Exp $

DESCRIPTION="XSL Stylesheets for Docbook"
HOMEPAGE="http://docbook.sourceforge.net/projects/xsl/index.html"
SRC_URI="mirror://sourceforge/docbook/docbook-xsl-${PV}.tar.bz2"

LICENSE="|| ( as-is BSD )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/libxml2
	>=app-text/build-docbook-catalog-1.1"

S=${WORKDIR}/docbook-xsl-${PV}


src_install() {
	# Create the installation directory
	DEST="/usr/share/sgml/docbook/xsl-stylesheets-${PV}"
	insinto ${DEST}

	local i
	for sheet in $(find . -maxdepth 1 -mindepth 1 -type d); do
		i=$(basename $sheet)
		cd ${S}/${i}
		for doc in ChangeLog README; do
			if [ -e "$doc" ]; then
				mv ${doc} ${doc}.${i}
				dodoc ${doc}.${i}
				rm ${doc}.${i}
			fi
		done

		doins -r ${S}/${i}
	done

	# Install misc. docs
	cd "${S}"
	dodoc AUTHORS BUGS ChangeLog NEWS README RELEASE-NOTES.txt TODO
	dohtml -r doc/*
	doins VERSION
}

pkg_postinst() {
	build-docbook-catalog
}

pkg_postrm() {
	build-docbook-catalog
}
