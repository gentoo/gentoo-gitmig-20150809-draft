# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/e2fsprogs/e2fsprogs-1.19-r1.ebuild,v 1.1 2001/02/07 15:51:27 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard ext2 filesystem utilities"
SRC_URI="ftp://download.sourceforge.net/pub/sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"

DEPEND="virtual/glibc
        >=sys-devel/gettext-0.10.35-r2"
RDEPEND="virtual/glibc"

src_compile() {

	try ./configure --host=${CHOST} --prefix=/usr \
                --mandir=/usr/share/man --infodir=/usr/share/info \
                --enable-elf-shlibs --enable-nls

	# Parallel make sometimes fails
	try make

}

src_install() {

	local myopts
	if [ "$DEBUG" ]
	then
	  myopts="STRIP=\"echo\""
	fi
        myopts="${myopts} mandir=/usr/share/man infodir=/usr/share/info"

	try make DESTDIR=${D} ${myopts} install
	try make DESTDIR=${D} ${myopts} install-libs

	dodoc COPYING ChangeLog README RELEASE-NOTES SHLIBS
	docinto e2fsck
	dodoc e2fsck/ChangeLog e2fsck/CHANGES
	for i in e2p et ext2fs ss uuid
	do
	  docinto lib/${i}
	  dodoc lib/${i}/ChangeLog
	done
	docinto misc
	dodoc misc/ChangeLog
	docinto resize
	dodoc resize/ChangeLog
	docinto util
	dodoc util/ChangeLog

}



