# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/xmlada/xmlada-0.7.1-r2.ebuild,v 1.1 2003/08/13 00:59:08 dholm Exp $

inherit gnat

IUSE=""

Name="XmlAda"

DESCRIPTION="XML library for Ada"
HOMEPAGE="http://libre.act-europe.fr/xmlada/"
SRC_URI="http://libre.act-europe.fr/xmlada/${Name}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-lang/gnat"
RDEPEND=""


src_unpack()
{
	unpack ${A}
	cd ${S}
	#making .dvi docs is problemmatic. Skip that for now
	sed -i -e "s/all: obj test docs/all: obj test/" Makefile.in
	#increase stack size
	cd sax
	sed -i -e "s/Stack_Size : constant Natural := 64;/Stack_Size : constant Natural := 128;/" sax-readers.adb

	#adjust xmlada-config to use new paths instead of hardcoded ones.
	cd ${S}
	sed -i -e "s#${prefix}/lib#${prefix}/lib/ada/adalib/xmlada#" xmlada-config.in
	sed -i -e "s#${prefix}/include/xmlada#${prefix}/lib/ada/adainclude/xmlada#" xmlada-config.in
}

src_compile()
{
	export CFLAGS=$ADACFLAGS
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--enable-shared \
		--host=${CHOST} \
		--build=${CHOST} \
		--target=${CHOST} \
		--with-system-zlib || die

	export COMPILER=gnatmake
	make || die "make failed"
}

src_install ()
{
	make PREFIX=${D}/usr install || die "install failed"

	#move components to GNAE compliant directories
	dodir /usr/lib/ada/adalib/${PN} /usr/lib/ada/adainclude/${PN}
	cd ${D}/usr/lib/
	mv * ${D}/usr/lib/ada/adalib/${PN}/
	cd ${D}/usr/include/${PN}/
	mv *.ali ${D}/usr/lib/ada/adalib/${PN}
	mv * ${D}/usr/lib/ada/adainclude/${PN}
	cd .. && rmdir ${PN}
	cd .. && rmdir include
	cd ${S}

	dodoc AUTHORS COPYING README TODO docs/xml.ps
	dohtml docs/*.html
	doinfo docs/*.info
	#need to give a proper name to info file
	cd ${D}/usr/share/info
	mv xml.info.gz ${PN}.info.gz

	dosym /usr/lib/ada/adalib/xmlada/libxmlada_dom.so /usr/lib
	dosym /usr/lib/ada/adalib/xmlada/libxmlada_input_sources.so /usr/lib
	dosym /usr/lib/ada/adalib/xmlada/libxmlada_sax.so /usr/lib
	dosym /usr/lib/ada/adalib/xmlada/libxmlada_unicode.so /usr/lib
}
