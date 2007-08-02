# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pure-ftpd/pure-ftpd-1.0.20-r1.ebuild,v 1.16 2007/08/02 15:55:22 uberlord Exp $

inherit eutils confutils

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

DESCRIPTION="Fast, production-quality, standard-conformant FTP server."
HOMEPAGE="http://www.pureftpd.org/"
SRC_URI="ftp://ftp.pureftpd.org/pub/${PN}/releases/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"

IUSE="caps ldap mysql pam postgres selinux ssl vchroot"

DEPEND="caps? ( sys-libs/libcap )
		ldap? ( >=net-nds/openldap-2.0.25 )
		mysql? ( virtual/mysql )
		pam? ( virtual/pam )
		postgres? ( >=dev-db/postgresql-7.2.2 )
		ssl? ( >=dev-libs/openssl-0.9.6g )"

RDEPEND="${DEPEND}
		selinux? ( sec-policy/selinux-ftpd )"

src_compile() {
	# adjust max user length to something more appropriate
	# for virtual hosts. See bug #62472 for details.
	sed -e "s:# define MAX_USER_LENGTH 32U:# define MAX_USER_LENGTH 127U:" -i "${S}/src/ftpd.h" || die "sed failed"

	local my_conf=""

	# Let's configure the USE-enabled stuff
	enable_extension_without	"capabilities"	"caps"
	enable_extension_with		"ldap"			"ldap"			0
	enable_extension_with		"mysql"			"mysql"			0
	enable_extension_with		"pam"			"pam"			0
	enable_extension_with		"pgsql"			"postgres"		0
	enable_extension_with		"tls"			"ssl"			0
	enable_extension_with		"virtualchroot"	"vchroot"		0

	econf \
		--with-altlog \
		--with-cookie \
		--with-diraliases \
		--with-extauth \
		--with-ftpwho \
		--with-largefile \
		--with-peruserlimits \
		--with-privsep \
		--with-puredb \
		--with-quotas \
		--with-ratios \
		--with-throttling \
		--with-uploadscript \
		--with-virtualhosts \
		${my_conf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS CONTACT ChangeLog FAQ HISTORY INSTALL README* NEWS

	if use pam ; then
		cp -f "${FILESDIR}/ftpusers" "${D}/etc/ftpusers"
		insinto /etc/pam.d
		doins pam/pure-ftpd
	fi

	insinto /etc/xinetd.d
	newins "${FILESDIR}/pure-ftpd.xinetd" pure-ftpd

	newconfd "${FILESDIR}/pure-ftpd.conf_d" pure-ftpd

	newinitd "${FILESDIR}/pure-ftpd.rc6" pure-ftpd

	if use ldap ; then
		insinto /etc/openldap/schema
		doins pureftpd.schema
		insinto /etc/openldap
		insopts -m 0600
		doins pureftpd-ldap.conf
	fi
}

pkg_postinst() {
	elog
	elog "Before starting Pure-FTPd, you have to edit the /etc/conf.d/pure-ftpd file!"
	elog
	ewarn "It's *really* important to read the README provided with Pure-FTPd!"
	ewarn "Check out http://download.pureftpd.org/pub/pure-ftpd/doc/README for general info"
	ewarn "and http://download.pureftpd.org/pub/pure-ftpd/doc/README.TLS for SSL/TLS info."
}
