# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/xmlada/xmlada-0.7.1.ebuild,v 1.1 2003/07/22 07:53:55 george Exp $

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


src_unpack()
{
	unpack ${A}
	cd ${S}
	#making .dvi docs is problemmatic. Skip that for now
	sed -i -e "s/all: obj test docs/all: obj test/" Makefile.in
	#increase stack size
	cd sax
	sed -i -e "s/Stack_Size : constant Natural := 64;/Stack_Size : constant Natural := 128;/" sax-readers.adb
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

	dodoc AUTHORS COPYING README TODO docs/xml.ps
	dohtml docs/*.html
	doinfo docs/*.info
	#need to give a proper name to info file
	cd ${D}/usr/share/info
	mv xml.info.gz ${PN}.info.gz
}
