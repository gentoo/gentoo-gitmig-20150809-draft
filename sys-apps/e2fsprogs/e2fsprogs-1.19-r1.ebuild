# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/e2fsprogs/e2fsprogs-1.19-r1.ebuild,v 1.3 2001/04/06 15:35:21 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard ext2 filesystem utilities"
SRC_URI="ftp://download.sourceforge.net/pub/sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )
	sys-apps/texinfo"
RDEPEND="virtual/glibc"

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p0 < ${FILESDIR}/${P}-po-Makefile.in.in-gentoo.diff
}

src_compile() {

    local myconf
    if [ "`use nls`" ]
    then
      myconf="--enable-nls"
    else
      myconf="--disable-nls"
    fi
	try ./configure --host=${CHOST} --prefix=/usr \
                --mandir=/usr/share/man --infodir=/usr/share/info \
                --enable-elf-shlibs ${myconf}

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

    if [ "`use nls`" ]
    then
      cd po
      try make DESTDIR=${D} install
    fi
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



