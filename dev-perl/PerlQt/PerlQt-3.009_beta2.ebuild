# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlQt/PerlQt-3.009_beta2.ebuild,v 1.4 2006/04/16 22:14:17 hansmi Exp $

inherit perl-module kde

#install pqtsh to this directory
myinst="${myinst} INSTBINDIR=${D}/usr/bin"
myconf="--enable-smoke --disable-libtool-lock"
mydoc="ChangeLog README TODO INSTALL COPYING AUTHORS"

DESCRIPTION="Perl bindings for the Qt 3.x toolkit"
HOMEPAGE="http://perlqt.sourceforge.net/"


SRC_URI="mirror://sourceforge/perlqt/${P/_beta2/-b2}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc ~sparc x86"
IUSE="arts"
S=${WORKDIR}/${P/_beta2/}

#if kdebindings is installed compilation is really fast!
# because libsmoke comes with kdebindings-3.1

DEPEND="=x11-libs/qt-3*
		kde-base/kdelibs"

src_unpack() {
	unpack ${A}
	cd ${S}/PerlQt
	#cp Makefile.PL.in Makefile.PL.in.orig
	#perl -pi -e "s#WriteMakefile\(#WriteMakefile\(\n'PREFIX' => '${D}/usr',\n#" Makefile.PL.in
	cd ${S}
}

src_compile() {
	useq arts || myconf="${myconf} --without-arts"
	addwrite $QTDIR/etc/settings
	perl Makefile.PL ${myconf} --prefix=${D}/usr --exec-prefix=/usr
	emake
}

src_install() {

	addwrite $QTDIR/etc/settings
	dodir /lib
	make PREFIX=/usr DESTDIR=${D} install || die
	mkdir -p ${D}/usr/share/doc/${P}/tutorials
	cp -r ${S}/PerlQt/tutorials/* ${D}/usr/share/doc/${P}/tutorials
	mv ${D}/${D}/usr ${D}/
	rm -rf ${D}/var

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


