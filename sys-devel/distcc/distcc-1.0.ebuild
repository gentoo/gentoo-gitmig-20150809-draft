# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-1.0.ebuild,v 1.2 2003/02/13 16:29:09 vapier Exp $

HOMEPAGE="http://distcc.samba.org/"
SRC_URI="http://distcc.samba.org/ftp/distcc/distcc-${PV}.tar.bz2"
DESCRIPTION="a program to distribute compilation of C code across several machines on a network"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"

DEPEND="dev-libs/popt"

src_compile() {
	econf
	emake || die "emake failed"
}

src_install() {
	einstall
	
	cd ${D}/usr/share/info
	rm -f distcc.info.gz
	
	exeinto /etc/init.d
	newexe ${FILESDIR}/distccd.1 distccd
}
