# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sgmltools-lite/sgmltools-lite-3.0.3-r6.ebuild,v 1.12 2004/10/18 16:42:33 usata Exp $

inherit sgml-catalog

SRC_URI="mirror://sourceforge/sgmltools-lite/${P}.tar.gz
		 mirror://sourceforge/sgmltools-lite/nw-eps-icons-0.0.1.tar.gz"
HOMEPAGE="http://sgmltools-lite.sourceforge.net/"
LICENSE="GPL-2"
DESCRIPTION="Python interface to SGML software specifically in a
DocBook/OpenJade environment.  Provides sgml2{html,txt,rtf,dvi,ps}"

SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc alpha amd64"

DEPEND="virtual/python
	app-text/sgml-common
	~app-text/docbook-sgml-dtd-3.1
	app-text/docbook-dsssl-stylesheets
	app-text/jadetex
	app-text/openjade
	net-www/lynx"

src_compile() {
	./configure 	\
		--prefix=/usr \
		--exec-prefix=/usr	\
		--bindir=/usr/bin	\
		--sbindir=/usr/sbin	\
		--datadir=/usr/share	\
		--mandir=/usr/share/man	|| die

	make || die

	#remove CVS directories from the tree
	for dirs in bin doc dsssl dtd man python rpm
	do
		rm -rf ${dirs}/CVS
	done

}

src_install() {
	make	\
		prefix=${D}/usr	\
		exec-prefix=${D}/usr	\
		datadir=${D}/usr/share	\
		bindir=${D}/usr/bin	\
		sysconfdir=${D}/etc	\
		mandir=${D}/usr/share/man	\
		etcdir=${D}/etc/sgml	\
		install || die

	dodoc COPYING ChangeLog POSTINSTALL README*
	dohtml -r .

	cd ${WORKDIR}/nw-eps-icons-0.0.1/images
	insinto /usr/share/sgml/docbook/dsssl-stylesheets/images
	doins *.eps

	cd callouts
	insinto /usr/share/sgml/docbook/dsssl-stylesheets/images/callouts
	doins *.eps

	rm ${D}/etc/sgml/catalog.{suse,rh62}

	# Create simple alias scripts that people are used to
	# And make the manpages for those link to the sgmltools-lite manpage
	mandir=${D}/usr/share/man/man1
	ScripTEXT="#!/bin/sh\n/usr/bin/sgmltools --backend="
	for back in html ps dvi rtf txt
	do
		echo -e ${ScripTEXT}${back} '$*' > sgml2${back}
		exeinto /usr/bin
		doexe sgml2${back}

		cd ${mandir}
		ln -sf sgmltools-lite.1.gz sgml2${back}.1.gz
		cd ${S}
	done

}

sgml-catalog_cat_include "/etc/sgml/sgml-lite.cat" \
	"/usr/share/sgml/stylesheets/sgmltools/sgmltools.cat"
