# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlQt/PerlQt-3.006.ebuild,v 1.5 2005/04/01 17:50:21 blubb Exp $

inherit kde perl-module

#install pqtsh to this directory
myinst="${myinst} INSTBINDIR=${D}/usr/bin"
myconf="${myconf} --prefix=${D}/usr"
mydoc="ChangeLog README TODO INSTALL COPYING AUTHORS"

DESCRIPTION="Perl bindings for the Qt 3.x toolkit"
HOMEPAGE="http://perlqt.sourceforge.net/"

SRC_URI="mirror://sourceforge/perlqt/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"


#if kdebindings is installed compilation is really fast!
# because libsmoke comes with kdebindings-3.1

DEPEND=" >=x11-libs/qt-3.0.0"

# may also works with kde 3.0, but not tested
need-kde 3.1

src_unpack() {
	unpack ${A}
	cd ${S}/PerlQt
	cp Makefile.PL.in Makefile.PL.in.orig
	perl -pi -e "s#WriteMakefile\(#WriteMakefile\(\n'PREFIX' => '${D}/usr',#" Makefile.PL.in
	cd ${S}
	perl-module_src_prep
}



src_install() {

	perl-module_src_install

	mkdir -p ${D}/usr/share/doc/${P}/tutorials
	cp -r ${S}/PerlQt/tutorials/* ${D}/usr/share/doc/${P}/tutorials

	for file in `find ${D}/usr/share/doc/${P}/tutorials/*/*.pl`;do
		perl -pi -e "s/use blib;/#use blib;/" ${file}
		chmod +x ${file}
	done

	mkdir -p ${D}/usr/share/doc/${P}/examples
	cp -r ${S}/PerlQt/examples/* ${D}/usr/share/doc/${P}/examples
	for file in `find ${D}/usr/share/doc/${P}/examples/*/*.pl`;do
		chmod +x ${file}
	done
}


