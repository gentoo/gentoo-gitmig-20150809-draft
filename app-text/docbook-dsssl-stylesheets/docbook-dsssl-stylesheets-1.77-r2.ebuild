# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-dsssl-stylesheets/docbook-dsssl-stylesheets-1.77-r2.ebuild,v 1.14 2004/03/21 08:19:55 kumba Exp $

inherit sgml-catalog

MY_P=${P/-stylesheets/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="DSSSL Stylesheets for DocBook."
SRC_URI="mirror://sourceforge/docbook/${MY_P}.tar.gz"
HOMEPAGE="http://www.sourceforge.net/docbook/"

RDEPEND="app-text/sgml-common"

SLOT="0"
LICENSE="as-is"
KEYWORDS="ia64 x86 ppc sparc alpha hppa amd64 mips"

sgml-catalog_cat_include "/etc/sgml/dsssl-docbook-stylesheets.cat" \
	"/usr/share/sgml/docbook/dsssl-stylesheets-${PV}/catalog"
sgml-catalog_cat_include "/etc/sgml/sgml-docbook.cat" \
	"/etc/sgml/dsssl-docbook-stylesheets.cat"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/${P}.Makefile Makefile
}

src_compile() {
	return 0
}

src_install () {

	make \
		BINDIR="${D}/usr/bin" \
		DESTDIR="${D}/usr/share/sgml/docbook/dsssl-stylesheets-${PV}" \
		install || die

	dodir /usr/share/sgml/stylesheets/dsssl/

	if [ -d /usr/share/sgml/stylesheets/dsssl/docbook ] &&
		[ ! -L /usr/share/sgml/stylesheets/dsssl/docbook ]
	then
		ewarn "Not linking /usr/share/sgml/stylesheets/dsssl/docbook to"
		ewarn "/usr/share/sgml/docbook/dsssl-stylesheets-${PV}"
		ewarn "as directory already exists there.  Will assume you know"
		ewarn "what you're doing."
		return 0
	fi

	dosym /usr/share/sgml/docbook/dsssl-stylesheets-${PV} \
		/usr/share/sgml/stylesheets/dsssl/docbook
}
