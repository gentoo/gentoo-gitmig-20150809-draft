# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.6.ebuild,v 1.4 2002/07/16 02:36:17 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Allows certain users/groups to run commands as root"
SRC_URI="ftp://ftp.sudo.ws/pub/sudo/${P}.tar.gz"
HOMEPAGE="http://www.sudo.ws/"
LICENSE="Sudo"

DEPEND="virtual/glibc pam? ( >=sys-libs/pam-0.73-r1 )"

KEYWORDS="x86 ppc"

src_compile() {
	local myconf
	if [ "`use pam`" ]
	then
		myconf="--with-pam"
	else
		myconf="--without-pam"
	fi
	./configure --prefix=/usr --host=${CHOST} --mandir=/usr/share/man  --sysconfdir=/etc --with-all-insults --disable-path-info --with-env-editor $myconf || die
	emake || die
}

src_install () {
	make prefix=${D}/usr sysconfdir=${D}/etc mandir=${D}/usr/share/man install || die
	dodoc BUGS CHANGES HISTORY LICENSE PORTING README RUNSON TODO TROUBLESHOOTING UPGRADE sample.*
	insinto /etc/pam.d
	doins ${FILESDIR}/sudo
}
