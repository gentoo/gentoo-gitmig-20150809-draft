# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tora/tora-1.3.11-r1.ebuild,v 1.2 2003/08/27 16:20:14 rizzo Exp $

DESCRIPTION="TOra - Toolkit For Oracle"
HOMEPAGE="http://www.globecom.se/tora/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-alpha-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/qt-3.0.0
	dev-lang/perl
	kde? ( >=kde-base/kdebase-3.1 )"

pkg_setup() {
	if [ "`use oci8`" -a ! $ORACLE_HOME ] ; then
		einfo "ORACLE_HOME variable is not set."
		einfo ""
        einfo "You must install Oracle >= 8i client for Linux in"
		einfo "order to compile TOra with Oracle support."
		einfo ""
		einfo "Otherwise specify -oci8 in your USE variable."
		einfo ""
		einfo "You can download the Oracle software from"
		einfo "http://otn.oracle.com/software/content.html"
		die
	fi
}

src_unpack() {
	unpack ${PN}-alpha-${PV}.tar.gz
	cd ${P}
	epatch ${FILESDIR}/tora-index-segfault.patch
}

src_compile() {
	local myconf

	use kde \
		&& myconf="$myconf --with-kde" \
		|| myconf="$myconf --without-kde"	
	use oci8 || myconf="$myconf --without-oracle"	

	./configure --prefix=/usr --with-mono $myconf || die "conf failed"
	emake || die "emake failed"
}

src_install() {
	dodir ${D}/usr/bin
	einstall ROOT=${D} 
	dodoc LICENSE.txt BUGS INSTALL NEWS README TODO
}
