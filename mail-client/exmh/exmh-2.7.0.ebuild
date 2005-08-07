# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/exmh/exmh-2.7.0.ebuild,v 1.5 2005/08/07 12:55:17 hansmi Exp $

inherit eutils

DESCRIPTION="An X user interface for MH mail"
SRC_URI="ftp://ftp.scriptics.com/pub/tcl/${PN}/${P}.tar.gz"
HOMEPAGE="http://beedub.com/exmh/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="ppc sparc x86"
IUSE="crypt"

DEPEND="mail-client/nmh
	dev-tcltk/expect
	net-mail/mailbase
	net-mail/metamail
	crypt? ( app-crypt/gnupg )
	>=dev-lang/tcl-8.2
	>=dev-lang/tk-8.2"

src_unpack() {
	unpack ${A}

	cd ${S}
	for i in *.MASTER; do cp $i ${i%%.MASTER}; done
	mv exmh.l exmh.1
	epatch ${FILESDIR}/${P}-conf.patch
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

	insinto /usr/lib/${P}
	doins lib/*

	insinto /usr/lib/${P}/bitmaps
	doins lib/bitmaps/*

	insinto /usr/lib/${P}/html
	doins lib/html/*

	insinto /etc
	doins gentoo/exmh.conf
}
