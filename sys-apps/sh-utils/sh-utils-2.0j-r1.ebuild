# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sh-utils/sh-utils-2.0j-r1.ebuild,v 1.1 2000/08/02 17:07:14 achim Exp $

P=sh-utils-2.0j
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Your standard GNU shell utilities"
CATEGORY="sys-apps"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"

src_compile() {                           
	./configure --host=${CHOST} --prefix=/usr \
	--with-catgets --without-included-regex
	make
}

src_install() {                               
	cd ${S}/src
	into /
	dobin echo hostname pwd true uname id stty date true false sleep su
	chmod u+s ${D}/bin/su
	into /usr
	dobin basename chroot dirname env expr factor groups id logname nice nohup pathchk printenv printf seq tee test tty users who whoami yes
	cd ${S}
	doinfo doc/sh-utils.info
	doman man/*.1
	MOPREFIX=sh-utils
	domo po/*.po
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog ChangeLog.0 NEWS README THANKS TODO
}



