# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/vsftpd/vsftpd-1.1.2.ebuild,v 1.4 2003/07/13 11:55:51 aliz Exp $

DESCRIPTION="Very Secure FTP Daemon written with speed, size and security in mind"
SRC_URI="ftp://vsftpd.beasts.org/users/cevans/${P}.tar.gz"
HOMEPAGE="http://vsftpd.beasts.org/"
DEPEND="pam? ( >=sys-libs/pam-0.75 )"
RDEPEND="|| ( sys-apps/xinetd >=sys-apps/ucspi-tcp-0.88-r3 )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc "

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	patch -p1 <${FILESDIR}/${P}-gentoo.diff || die "bad patchfile"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "compile problem"
}

src_install() {
	into /usr
	doman vsftpd.conf.5 vsftpd.8
	dosbin vsftpd

	dodoc AUDIT BENCHMARKS BUGS Changelog FAQ INSTALL \
		LICENSE README README.security REWARD SIZE \
		SPEED TODO TUNING
	newdoc ${FILESDIR}/vsftpd.conf vsftpd.conf.sample
	newdoc vsftpd.conf vsftpd.conf.dist.sample
	docinto security ; dodoc SECURITY/*
	cp -a EXAMPLE ${D}/usr/share/doc/${PF}/examples

	insinto /etc ; doins ${FILESDIR}/ftpusers
	insinto /etc/vsftpd ; newins ${FILESDIR}/vsftpd.conf vsftpd.conf.sample
	insinto /etc/xinetd.d ; newins ${FILESDIR}/vsftpd.xinetd vsftpd
	insinto /etc/pam.d ; newins ${FILESDIR}/vsftpd.pam vsftpd
}

pkg_postinst() {
	# empty dirs...
	install -m0755 -o root -g root -d ${ROOT}/home/ftp
	install -m0755 -o root -g root -d ${ROOT}/usr/share/vsftpd/empty
	install -m0755 -o root -g root -d ${ROOT}/var/log/vsftpd
}
