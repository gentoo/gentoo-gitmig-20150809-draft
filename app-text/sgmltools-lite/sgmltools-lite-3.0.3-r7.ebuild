# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sgmltools-lite/sgmltools-lite-3.0.3-r7.ebuild,v 1.2 2004/01/01 13:51:19 gmsoft Exp $

inherit sgml-catalog

DESCRIPTION="Python interface to SGML software specificially in a
DocBook/OpenJade environment.  Provides sgml2{html,txt,rtf,dvi,ps}"
HOMEPAGE="http://sgmltools-lite.sourceforge.net/"
SRC_URI="mirror://sourceforge/sgmltools-lite/${P}.tar.gz
		 mirror://sourceforge/sgmltools-lite/nw-eps-icons-0.0.1.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE="tetex"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 hppa"

DEPEND="virtual/python
	app-text/sgml-common
	=app-text/docbook-sgml-dtd-3.1-r1
	app-text/docbook-dsssl-stylesheets
	app-text/openjade
	net-www/lynx
	tetex? ( app-text/jadetex )"

src_compile() {

	econf || die
	emake || die

	#remove CVS directories from the tree
	find . -name CVS | xargs rm -rf

}

src_install() {

	einstall etcdir=${D}/etc/sgml || die

	dodoc COPYING ChangeLog POSTINSTALL README*
	dohtml -r .

	cd ${WORKDIR}/nw-eps-icons-0.0.1/images
	insinto /usr/share/sgml/docbook/dsssl-stylesheets/images
	doins *.eps

	cd callouts
	insinto /usr/share/sgml/docbook/dsssl-stylesheets/images/callouts
	doins *.eps

	rm ${D}/etc/sgml/catalog.{suse,rh62}

	# Remove the backends that require tetex
	use tetex || \
		rm ${D}/usr/share/sgml/misc/sgmltools/python/backends/{Dvi,Ps,Pdf,JadeTeX}.py

	# The list of backends to alias with sgml2* 
	BACKENDS="html rtf txt"
	use tetex && BACKENDS="${BACKENDS} ps dvi pdf"

	# Create simple alias scripts that people are used to
	# And make the manpages for those link to the sgmltools-lite manpage
	mandir=${D}/usr/share/man/man1
	ScripTEXT="#!/bin/sh\n/usr/bin/sgmltools --backend="
	for back in ${BACKENDS}
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
