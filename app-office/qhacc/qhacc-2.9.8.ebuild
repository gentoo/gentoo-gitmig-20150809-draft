# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qhacc/qhacc-2.9.8.ebuild,v 1.1 2004/03/06 21:25:35 centic Exp $

inherit libtool

IUSE="mysql xml"

DESCRIPTION="Personal Finance for QT"
HOMEPAGE="http://qhacc.sourceforge.net"
SRC_URI="mirror://sourceforge/sourceforge/qhacc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND="mysql? ( dev-db/mysql++ )
	xml? ( dev-libs/libxml sys-libs/zlib )
	>=x11-libs/qt-3"

src_compile() {

	elibtoolize

	local myconf=""
	use mysql || myconf="${myconf} --disable-mysql"
	use xml || myconf="${myconf} --disable-xml"

	econf ${myconf} || die "configure failed"

	make || die "make failed"

}

src_install() {

	einstall || die "install failed"

	dodir /etc/qhacc
	cp -R ${S}/contrib/easysetup/* ${D}/etc/qhacc/
}

pkg_postinst() {
	einfo "Copy the files in /etc/qhacc to ~/.qhacc,
	You have to run this program with the command:
	qhacc -f ~/.qhacc/
	I prefer to put this in my .bashrc
	alias qhacc=\"qhacc -f ~/.qhacc\""
}
