# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/sgml-common/sgml-common-0.6.3-r2.ebuild,v 1.6 2002/09/21 11:49:09 bjb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Base ISO character entities and utilities for SGML"
SRC_URI="ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/${P}.tgz
	http://download.sourceforge.net/pub/mirrors/kde/devel/docbook/SOURCES/${P}.tgz"
HOMEPAGE="http://www.iso.ch/cate/3524030.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"
src_unpack() {

	unpack ${A}
	# We use a hacked version of install-catalog that supports the ROOT variable
	cp ${FILESDIR}/${P}-install-catalog.in ${S}/bin
}

src_compile() {
	./configure	\
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man || die

	emake || die
}

src_install () {
	make \
		prefix=${D}/usr	\
		sysconfdir=${D}/etc	\
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc \
		install || die

}

pkg_postinst() {
	if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ]
	then
		echo ">>> Installing Catalogs..."
		install-catalog --add \
			/etc/sgml/sgml-ent.cat \
			/usr/share/sgml/sgml-iso-entities-8879.1986/catalog

		install-catalog --add \
			/etc/sgml/sgml-docbook.cat \
			/etc/sgml/sgml-ent.cat
	else
		echo "install-catalog not found!"
	fi
}

pkg_prerm() {
	cp /usr/bin/install-catalog ${T}
}

pkg_postrm() {
	if [ ! -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ]
	then
		echo ">>> Removing Catalogs..."
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

