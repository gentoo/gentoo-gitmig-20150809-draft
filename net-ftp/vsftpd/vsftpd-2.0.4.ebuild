# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/vsftpd/vsftpd-2.0.4.ebuild,v 1.1 2006/01/10 07:17:30 uberlord Exp $

inherit flag-o-matic eutils

DESCRIPTION="Very Secure FTP Daemon written with speed, size and security in mind"
HOMEPAGE="http://vsftpd.beasts.org/"
SRC_URI="ftp://vsftpd.beasts.org/users/cevans/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="logrotate pam tcpd ssl selinux xinetd"

DEPEND="pam? ( || ( virtual/pam sys-libs/pam ) )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.7d )"
RDEPEND="${DEPEND}
	net-ftp/ftpbase
	logrotate? ( app-admin/logrotate )
	selinux? ( sec-policy/selinux-ftpd )
	xinetd? ( sys-apps/xinetd )"

src_unpack() {
	unpack "${A}" || die
	cd "${S}" || die

	use tcpd && echo "#define VSF_BUILD_TCPWRAPPERS" >> builddefs.h
	use ssl && echo "#define VSF_BUILD_SSL" >> builddefs.h
	use pam || echo "#undef VSF_BUILD_PAM" >> builddefs.h

	# Patch the source, config and the manpage to use /etc/vsftpd/
	epatch "${FILESDIR}/vsftpd-2.0.3-gentoo.patch"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	into /usr
	doman vsftpd.conf.5 vsftpd.8
	dosbin vsftpd

	dodoc AUDIT BENCHMARKS BUGS Changelog FAQ INSTALL \
		LICENSE README README.security REWARD SIZE \
		SPEED TODO TUNING
	newdoc vsftpd.conf vsftpd.conf.example

	docinto security
	dodoc SECURITY/*

	insinto "/usr/share/doc/${PF}/examples"
	doins -r EXAMPLE/*

	insinto /etc/vsftpd
	newins vsftpd.conf vsftpd.conf.example

	if use logrotate ; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/vsftpd.logrotate" vsftpd
	fi

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/vsftpd.xinetd" vsftpd
	fi

	newinitd "${FILESDIR}/vsftpd.init" vsftpd

	keepdir /usr/share/vsftpd/empty
}

pkg_preinst() {
	# If we use xinetd, then we comment out listen=YES
	# so that our default config works under xinetd - fixes #78347
	if use xinetd ; then
		sed -i '/\listen=YES/s/^/#/g' ${IMAGE}/etc/vsftpd/vsftpd.conf.example
	fi
}

pkg_postinst() {
	einfo "vsftpd init script can now be multiplexed."
	einfo "The default init script forces /etc/vsftpd/vsftpd.conf to exist."
	einfo "If you symlink the init script to another one, say vsftpd.foo"
	einfo "then that uses /etc/vsftpd/foo.conf instead."
	einfo
	einfo "Example:"
	einfo "   cd /etc/init.d"
	einfo "   ln -s vsftpd vsftpd.foo"
	einfo "You can now treat vsftpd.foo like any other service"
}
