# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/noflushd/noflushd-2.4-r6.ebuild,v 1.1 2001/10/18 20:09:25 woodchip Exp $
# Note: the daemon's current 2.4 version has nothing to do with kernel versions

A=noflushd_2.4.orig.tar.gz
S=${WORKDIR}/${P}.orig
SRC_URI="http://download.sourceforge.net/noflushd/${A}"

HOMEPAGE="http://noflushd.sourceforge.net"
DESCRIPTION="A daemon to spin down your disks and force accesses to be cached"

DEPEND="virtual/glibc
	sys-devel/ld.so"

src_compile() {

	./configure --prefix=/usr --host=${CHOST} --mandir=/usr/share/man \
	--infodir=/usr/share/info --with-docdir=/usr/share/doc/${PF} || die

	emake || die
}

src_install () {

	dosbin src/noflushd
	doman man/noflushd.8
	dodoc README NEWS

	exeinto /etc/init.d ; newexe ${FILESDIR}/noflushd.rc6 noflushd
}

pkg_postinst() {
    
	echo "
	Run 'rc-update add noflushd' to add it to default runlevel.

	WARNING:
	WARNING: Do NOT use with SCSI, unstable!
	WARNING: Has possible problems with reiserfs, too.
	WARNING:
	"
}
