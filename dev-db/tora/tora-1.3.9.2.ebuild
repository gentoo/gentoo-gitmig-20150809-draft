# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/tora/tora-1.3.9.2.ebuild,v 1.2 2003/04/22 14:23:19 phosphan Exp $

S=${WORKDIR}/${P}
DESCRIPTION="TOra - Toolkit For Oracle"
SRC_URI="mirror://sourceforge/${PN}/${PN}-alpha-${PV}.tar.gz"
HOMEPAGE="http://www.globecom.se/tora/"
DEPEND=">=x11-libs/qt-3.0.0
		dev-lang/perl
		kde? ( >=kde-base/kde-2.2 )"
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

src_compile() {
	local myconf

	use kde		&& myconf="$myconf --with-kde" \
				|| myconf="$myconf --without-kde"	
	use oci8	|| myconf="$myconf --without-oracle"	

	./configure --prefix=/usr --with-mono $myconf
	emake || die "emake failed"
}

src_install() {
	dodir ${D}/usr/bin
	einstall ROOT=${D} 
}

pkg_setup () {                                                               

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
