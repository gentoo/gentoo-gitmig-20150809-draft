# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/exmh/exmh-2.5.ebuild,v 1.3 2002/07/17 06:38:03 seemant Exp $

DESCRIPTION="An X user interface for MH mail"
SRC_URI="ftp://ftp.scriptics.com/pub/tcl/${PN}/${PN}-${PV}.tar.gz"
HOMEPAGE="http://beedub.com/exmh/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND="net-mail/nmh
	dev-tcltk/expect
	net-mail/mailbase
	crypto? ( app-crypt/gnupg )
	>=dev-lang/tcl-8.2
	>=dev-lang/tk-8.2"

src_unpack() {
	unpack ${A}

	cd ${S}
	for i in *.MASTER; do cp $i ${i%%.MASTER}; done
	mv exmh.l exmh.1
    patch -p1 < ${FILESDIR}/exmh-2.5-conf.patch
	cd misc
	rm -rf RPM *tar* *gbuffy*
	for i in *
	do
		mv $i $i.orig
		sed -e "s:/usr/local/bin:/usr/bin:" $i.orig > $i
		mv $i $i.orig
		sed -e "s:/usr/local/nmh/bin:/usr/bin:" $i.orig > $i
		mv $i $i.orig
		sed -e "s:/usr/local/nmh/lib:/usr/bin:" $i.orig > $i
		rm $i.orig
	done
}

src_compile() {                           
	echo 'auto_mkindex ./lib *.tcl' | tclsh
}

src_install() {                               
	into /usr
	dobin exmh exmh-bg exmh-async ftp.expect

	doman exmh.1

	dodoc COPYRIGHT exmh.CHANGES exmh.README misc/*

	mkdir -p ${D}/usr/lib/${PN}-${PV}
	install -m 644 lib/* ${D}/usr/lib/${PN}-${PV}
}
