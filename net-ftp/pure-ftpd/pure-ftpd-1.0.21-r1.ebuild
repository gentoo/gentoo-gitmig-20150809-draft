# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pure-ftpd/pure-ftpd-1.0.21-r1.ebuild,v 1.6 2006/12/01 17:46:14 corsair Exp $

inherit eutils confutils

KEYWORDS="~alpha ~amd64 hppa ~ia64 ppc ppc64 sparc ~x86"

DESCRIPTION="Fast, production-quality, standard-conformant FTP server."
HOMEPAGE="http://www.pureftpd.org/"
SRC_URI="ftp://ftp.pureftpd.org/pub/${PN}/releases/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"

IUSE="caps charconv ldap mysql noiplog pam paranoidmsg postgres selinux ssl vchroot xinetd"

DEPEND="caps? ( sys-libs/libcap )
		charconv? ( virtual/libiconv )
		ldap? ( >=net-nds/openldap-2.0.25 )
		mysql? ( virtual/mysql )
		pam? ( virtual/pam )
		postgres? ( >=dev-db/postgresql-7.2.2 )
		ssl? ( >=dev-libs/openssl-0.9.6g )
		xinetd? ( sys-apps/xinetd )"

RDEPEND="${DEPEND}
		net-ftp/ftpbase
		selinux? ( sec-policy/selinux-ftpd )"

src_unpack() {
	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}/${P}-pam.patch"
}

src_compile() {
	# adjust max user length to something more appropriate
	# for virtual hosts. See bug #62472 for details.
	sed -e "s:# define MAX_USER_LENGTH 32U:# define MAX_USER_LENGTH 127U:" -i "${S}/src/ftpd.h" || die "sed failed"

	local my_conf=""

	# Let's configure the USE-enabled stuff
	enable_extension_without	"capabilities"	"caps"
	enable_extension_with		"rfc2640"		"charconv"		0
	enable_extension_with		"ldap"			"ldap"			0
	enable_extension_with		"mysql"			"mysql"			0
	enable_extension_with		"pam"			"pam"			0
	enable_extension_with		"paranoidmsg"	"paranoidmsg"	0
	enable_extension_with		"pgsql"			"postgres"		0
	enable_extension_with		"tls"			"ssl"			0
	enable_extension_with		"virtualchroot"	"vchroot"		0
	enable_extension_without	"inetd"			"xinetd"

	# noiplog is a negative flag, we don't want that enabled by default,
	# so we handle it manually, as confutils can't do that
	use noiplog && my_conf="${my_conf} --without-iplogging"

	econf \
		--with-altlog \
		--with-cookie \
		--with-diraliases \
		--with-extauth \
		--with-ftpwho \
		--with-language=${PUREFTPD_LANG:=english} \
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

	newconfd "${FILESDIR}/pure-ftpd.conf_d" pure-ftpd

	newinitd "${FILESDIR}/pure-ftpd.rc6" pure-ftpd

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/pure-ftpd.xinetd" pure-ftpd
	fi

	if use ldap ; then
		dodir /etc/openldap/schema
		insinto /etc/openldap/schema
		doins pureftpd.schema
		insinto /etc/openldap
		insopts -m 0600
		doins pureftpd-ldap.conf
	fi
}

pkg_postinst() {
	einfo
	einfo "Before starting Pure-FTPd, you have to edit the /etc/conf.d/pure-ftpd file!"
	einfo
	ewarn "It's *really* important to read the README provided with Pure-FTPd!"
	ewarn "Check out http://download.pureftpd.org/pub/pure-ftpd/doc/README for general info"
	ewarn "and http://download.pureftpd.org/pub/pure-ftpd/doc/README.TLS for SSL/TLS info."
	einfo
	if use charconv ; then
		ewarn "Charset conversion is an *experimental* feature!"
		ewarn "Remember to set a valid charset for your filesystem in the configuration!"
		einfo
	fi
}
