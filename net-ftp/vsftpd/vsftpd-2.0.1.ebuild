# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/vsftpd/vsftpd-2.0.1.ebuild,v 1.1 2004/09/23 12:36:57 jforman Exp $

inherit flag-o-matic eutils

DESCRIPTION="Very Secure FTP Daemon written with speed, size and security in mind"
HOMEPAGE="http://vsftpd.beasts.org/"
SRC_URI="ftp://vsftpd.beasts.org/users/cevans/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-alpha -amd64 -ia64 -ppc -ppc64 -s390 -sparc -x86"
IUSE="pam tcpd ipv6 ssl"

DEPEND="pam? ( >=sys-libs/pam-0.75 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.7d-r1 )"
RDEPEND="${DEPEND} || ( sys-apps/xinetd >=sys-apps/ucspi-tcp-0.88-r3 )"

src_unpack() {
	filter-flags "-fPIC"
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/${PN}-1.2.1-gentoo.diff.bz2 || die
	use tcpd && echo '#define VSF_BUILD_TCPWRAPPERS' >> builddefs.h
	use ssl && echo '#define VSF_BUILD_SSL' >> builddefs.h
}

src_compile() {
	if use pam; then
		emake CFLAGS="${CFLAGS} -DUSE_PAM" || die
	else
		emake CFLAGS="${CFLAGS}" \
		LIBS='`./vsf_findlibs.sh | sed "/[/-]\<.*pam.*\>/d"`' || die
	fi
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
	chown -R root:root ${D}/usr/share/doc/${PF} # :\

	insinto /etc/vsftpd ; doins ${FILESDIR}/ftpusers
	insinto /etc/vsftpd ; newins ${FILESDIR}/vsftpd.conf vsftpd.conf.sample

	# for running vsftpd from xinetd
	insinto /etc/xinetd.d
	if ! use ipv6; then
		newins ${FILESDIR}/vsftpd.xinetd.ipv6 vsftpd
	else
		newins ${FILESDIR}/vsftpd.xinetd vsftpd
	fi
	insinto /etc/pam.d ; newins ${FILESDIR}/vsftpd.pam vsftpd

	# for running vsftpd standalone
	insinto /etc/conf.d
	newins ${FILESDIR}/vsftpd.conf.d vsftpd
	exeinto /etc/init.d
	newexe ${FILESDIR}/vsftpd.init.d vsftpd
}

pkg_postinst() {
	# empty dirs...
	install -m0755 -o root -g root -d ${ROOT}/home/ftp
	install -m0755 -o root -g root -d ${ROOT}/usr/share/vsftpd/empty
	install -m0755 -o root -g root -d ${ROOT}/var/log/vsftpd

	/etc/init.d/depscan.sh
}
