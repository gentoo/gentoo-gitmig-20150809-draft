# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/vsftpd/vsftpd-1.2.0-r1.ebuild,v 1.5 2004/01/08 02:35:59 weeve Exp $

inherit flag-o-matic eutils

IUSE="pam tcpd ipv6"

DESCRIPTION="Very Secure FTP Daemon written with speed, size and security in mind"
SRC_URI="ftp://vsftpd.beasts.org/users/cevans/${P}.tar.gz"
HOMEPAGE="http://vsftpd.beasts.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~hppa -alpha"

DEPEND="pam? ( >=sys-libs/pam-0.75 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
RDEPEND="${DEPEND} || ( sys-apps/xinetd >=sys-apps/ucspi-tcp-0.88-r3 )"

filter-flags "-fPIC"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/${P}-gentoo.diff.bz2 || die
	use tcpd && echo '#define VSF_BUILD_TCPWRAPPERS' >> builddefs.h
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
	if [ ! -n `use ipv6` ]; then
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
