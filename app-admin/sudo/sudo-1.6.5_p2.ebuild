# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.5_p2.ebuild,v 1.2 2002/03/10 11:49:24 blocke Exp $

NP=sudo-1.6.5p2
S=${WORKDIR}/${NP}
DESCRIPTION="Allows certain users/groups to run commands as root"
SRC_URI="ftp://ftp.sudo.ws/pub/sudo/${NP}.tar.gz"
HOMEPAGE="http://www.sudo.ws/"

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
	dodoc BUGS CHANGES HISTORY LICENSE PORTING README RUNSON TODO TROUBLESHOOTING UPGRADE sample.*
	insinto /etc/pam.d
	doins ${FILESDIR}/sudo
}

