# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sgml-common/sgml-common-0.6.3-r4.ebuild,v 1.27 2004/10/23 06:01:40 mr_bones_ Exp $

DESCRIPTION="Base ISO character entities and utilities for SGML"
HOMEPAGE="http://www.iso.ch/cate/3524030.html"
SRC_URI="mirror://kde/devel/docbook/SOURCES/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64 ppc-macos"
IUSE=""

DEPEND=">=sys-devel/automake-1.6"
RDEPEND=""

src_unpack() {
	unpack ${A}
	# We use a hacked version of install-catalog that supports the ROOT
	# variable, and puts quotes around the CATALOG files.
	cp "${FILESDIR}/${PF}-install-catalog.in" "${S}/bin/install-catalog.in"
	cd "${S}"
	automake -a
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}

pkg_postinst() {
	local file

	if [ -x "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ]
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
