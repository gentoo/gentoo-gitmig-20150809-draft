# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.4.ebuild,v 1.2 2002/01/16 20:24:59 drobbins Exp $

S=${WORKDIR}/${P}p1
DESCRIPTION="Allows certain users/groups to run commands as root"
SRC_URI="http://www.courtesan.com/sudo/dist/${P}.tar.gz"
HOMEPAGE="http://www.courtesan.com/sudo/"

DEPEND="virtual/glibc pam? ( >=sys-libs/pam-0.73-r1 )"

src_compile() {
	local myconf
	if [ "`use pam`" ]
	then
		myconf="--with-pam"
	else
		myconf="--without-pam"
	fi
	./configure --prefix=/usr --host=${CHOST} --mandir=/usr/share/man  --sysconfdir=/etc --with-all-insults --disable-path-info $myconf || die
	emake || die
}

src_install () {
	make prefix=${D}/usr sysconfdir=${D}/etc mandir=${D}/usr/share/man install || die
	dodoc BUGS CHANGES FAQ HISTORY LICENSE PORTING README RUNSON TODO TROUBLESHOOTING UPGRADE sample.*
	insinto /etc/pam.d
	doins ${FILESDIR}/sudo
}

