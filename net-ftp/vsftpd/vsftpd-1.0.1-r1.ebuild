# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-ftp/vsftpd/vsftpd-1.0.1-r1.ebuild,v 1.4 2002/09/21 02:26:29 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Very Secure FTP Daemon written with speed, size and security in mind"
SRC_URI="ftp://vsftpd.beasts.org/users/cevans/${P}.tar.gz"
HOMEPAGE="http://vsftpd.beasts.org/"

DEPEND=">=sys-libs/pam-0.75"
RDEPEND="sys-apps/xinetd"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_unpack() {
	unpack ${A} ; cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die "bad patchfile"
}

src_compile() {
	make CFLAGS="${CFLAGS}" || die "compile problem"
}

src_install () {
	dodir /home/ftp /usr/share/vsftpd/empty /var/log/vsftpd
	doman vsftpd.conf.5 vsftpd.8
	dosbin vsftpd

	dodoc AUDIT BENCHMARKS BUGS Changelog FAQ INSTALL KERNEL-2.4.0-WARNING
	dodoc LICENSE README README.security REWARD SIZE SPEED TODO TUNING
	docinto security ; dodoc SECURITY/*
	newdoc ${FILESDIR}/vsftpd.conf vsftpd.conf.sample
	newdoc vsftpd.conf vsftpd.conf.dist.sample

	insinto /etc ; doins ${FILESDIR}/ftpusers
	insinto /etc/vsftpd ; newins ${FILESDIR}/vsftpd.conf vsftpd.conf.sample
	insinto /etc/xinetd.d ; newins ${FILESDIR}/vsftpd.xinetd vsftpd
	insinto /etc/pam.d ; newins ${FILESDIR}/vsftpd.pam vsftpd
}
