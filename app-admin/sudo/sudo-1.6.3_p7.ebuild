# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# Author Achim Gottinger <achim@gentoo.org> Update from p5 to p7
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.3_p7.ebuild,v 1.1 2001/04/09 20:11:58 achim Exp $

P=${PN}-1.6.3p7
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Allows certain users/groups to run commands as root"
SRC_URI="http://www.courtesan.com/sudo/dist/${A}"
HOMEPAGE="http://www.courtesan.com/sudo/"

DEPEND="virtual/glibc
        pam? ( >=sys-libs/pam-0.73-r1 )"

src_compile() {
    
    if [ "`use pam`" ]
    then
        myconf="--with-pam"
    else
        myconf="--without-pam"
    fi
    echo $myconf
    try ./configure --prefix=/usr --host=${CHOST} --mandir=/usr/share/man  --sysconfdir=/etc \
        --with-all-insults --disable-path-info $myconf
    try make
}

src_install () {

    try make prefix=${D}/usr sysconfdir=${D}/etc mandir=${D}/usr/share/man install

    dodoc BUGS CHANGES FAQ HISTORY LICENSE PORTING README RUNSON TODO TROUBLESHOOTING UPGRADE sample.*

    insinto /etc/pam.d
    doins ${FILESDIR}/sudo
}

