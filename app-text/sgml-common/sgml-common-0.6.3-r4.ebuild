# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sgml-common/sgml-common-0.6.3-r4.ebuild,v 1.13 2004/03/21 07:43:51 kumba Exp $

DESCRIPTION="Base ISO character entities and utilities for SGML"
SRC_URI="mirror://kde/devel/docbook/SOURCES/${P}.tgz"
HOMEPAGE="http://www.iso.ch/cate/3524030.html"
LICENSE="GPL-2"


SLOT="0"
IUSE=""
KEYWORDS="ia64 ~x86 ppc ~sparc ~alpha ~hppa ~amd64 mips"

DEPEND=">=sys-devel/automake-1.6"
RDEPEND=""

src_unpack() {
	unpack ${A}
	# We use a hacked version of install-catalog that supports the ROOT
	# variable, and puts quotes around the CATALOG files.
	cp ${FILESDIR}/${PF}-install-catalog.in ${S}/bin/install-catalog.in
}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	emake \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc \
		install || die
}

pkg_postinst() {
	if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ]
	then
		einfo "Installing Catalogs..."
		install-catalog --add \
			/etc/sgml/sgml-ent.cat \
			/usr/share/sgml/sgml-iso-entities-8879.1986/catalog

		install-catalog --add \
			/etc/sgml/sgml-docbook.cat \
			/etc/sgml/sgml-ent.cat
	else
		ewarn "install-catalog not found! Something went wrong!"
		die
	fi
	for file in `find /etc/sgml/ -name "*.cat"` /etc/sgml/catalog
	do
		einfo "Fixing ${file}"
		awk '/"$/ { print $1 " " $2 }
			! /"$/ { print $1 " \"" $2 "\"" }' ${file} > ${file}.new
		mv ${file}.new ${file}
	done

}

pkg_prerm() {
	cp /usr/bin/install-catalog ${T}
}

pkg_postrm() {
	if [ ! -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ]
	then
		einfo "Removing Catalogs..."
		if [ -e /etc/sgml/sgml-ent.cat ]
		then
		${T}/install-catalog --remove \
			/etc/sgml/sgml-ent.cat \
			/usr/share/sgml/sgml-iso-entities-8879.1986/catalog
		fi

		if [ -e /etc/sgml/sgml-docbook.cat ]
		then
		${T}/install-catalog --remove \
			/etc/sgml/sgml-docbook.cat \
			/etc/sgml/sgml-ent.cat
		fi
	fi
}

