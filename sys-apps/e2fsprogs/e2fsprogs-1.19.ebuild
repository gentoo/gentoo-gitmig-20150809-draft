# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/e2fsprogs/e2fsprogs-1.19.ebuild,v 1.6 2001/01/31 20:49:06 achim Exp $

P=e2fsprogs-1.19
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard ext2 filesystem utilities"
SRC_URI="ftp://download.sourceforge.net/pub/sourceforge/e2fsprogs/e2fsprogs-1.19.tar.gz"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"

DEPEND=">=sys-libs/glibc-2.1.3"
RDEPEND="$DEPEND
	>=sys-apps/bash-2.04"

src_compile() {                           
	try ./configure --host=${CHOST} --enable-elf-shlibs --enable-nls
	# do not use pmake recursive
	try make 
	#$MAKEOPTS

}

src_install() {                               
	into /usr
	local myopts
	if [ "$DEBUG" ]
	then
	  myopts="STRIP=\"echo\""
	fi
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



