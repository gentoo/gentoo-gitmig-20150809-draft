# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/sgmltools-lite/sgmltools-lite-3.0.3-r4.ebuild,v 1.5 2002/07/16 04:09:40 owen Exp $

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/sgmltools-lite/${P}.tar.gz
		 mirror://sourceforge/sgmltools-lite/nw-eps-icons-0.0.1.tar.gz"
HOMEPAGE="sgmltools-lite.sourceforge.net"
DESCRIPTION="Python interface to SGML software specificially in a DocBook/OpenJade environment.  Provides sgml2{html,txt,rtf,dvi,ps}"

DEPEND="virtual/python
	app-text/sgml-common
	=app-text/docbook-sgml-dtd-3.1
	app-text/docbook-dsssl-stylesheets
	app-text/jadetex
	app-text/openjade
	net-www/lynx"

KEYWORDS="x86 ppc"

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
	ScripTEXT="/usr/bin/sgmltools --backend="
	for back in html ps dvi rtf txt
	do
		echo "${ScripTEXT}${back}" > sgml2${back}
		exeinto /usr/bin
		doexe sgml2${back}

		cd ${mandir}
		ln -sf sgmltools-lite.1.gz sgml2${back}.1.gz
		cd ${S}
	done

	
}

pkg_postinst() {

	gensgmlenv
	grep -v export /etc/sgml/sgml.env > /etc/env.d/93sgmltools-lite
}
