# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/noflushd/noflushd-2.4-r6.ebuild,v 1.9 2003/04/16 17:51:07 cretin Exp $
# Note: the daemon's current 2.4 version has nothing to do with kernel versions

MY_P=${P/-/_}
S=${WORKDIR}/${P}.orig
SRC_URI="http://download.sourceforge.net/noflushd/${MY_P}.orig.tar.gz"
HOMEPAGE="http://noflushd.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="A daemon to spin down your disks and force accesses to be cached"

DEPEND="virtual/glibc"

src_compile() {

	./configure --prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--with-docdir=/usr/share/doc/${PF} || die

	emake || die
}

src_install () {

	dosbin src/noflushd
	doman man/noflushd.8
	dodoc README NEWS

	exeinto /etc/init.d ; newexe ${FILESDIR}/noflushd.rc6 noflushd
	insinto /etc/conf.d ; newins ${FILESDIR}/noflushd.confd noflushd
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
