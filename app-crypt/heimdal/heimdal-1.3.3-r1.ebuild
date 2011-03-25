# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-1.3.3-r1.ebuild,v 1.10 2011/03/25 07:27:23 eras Exp $

EAPI=2
VIRTUALX_REQUIRED="manual"

inherit libtool virtualx eutils toolchain-funcs

#RESTRICT="test"

DESCRIPTION="Kerberos 5 implementation from KTH"
HOMEPAGE="http://www.h5l.org/"
SRC_URI="http://www.h5l.org/dist/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="afs +berkdb hdb-ldap ipv6 otp pkinit ssl threads test X"

RDEPEND="ssl? ( dev-libs/openssl )
	berkdb? ( sys-libs/db )
	!berkdb? ( sys-libs/gdbm )
	>=dev-db/sqlite-3.5.7
	>=sys-libs/e2fsprogs-libs-1.41.11
	afs? ( net-fs/openafs )
	hdb-ldap? ( >=net-nds/openldap-2.3.0 )
	!!app-crypt/mit-krb5"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/autoconf-2.62
	test? ( X? ( ${VIRTUALX_DEPEND} ) )"

src_prepare() {
	epatch "${FILESDIR}/heimdal_db5.patch"
	epatch "${FILESDIR}/heimdal_testsuite.patch"
	epatch "${FILESDIR}/heimdal_testsuite_extra.patch"
	epatch "${FILESDIR}/heimdal_disable-check-iprop.patch"
	epatch "${FILESDIR}/heimdal_openssl-1.patch"
}

src_configure() {
	econf \
		--enable-kcm \
		--disable-osfc2 \
		--enable-shared \
		--with-libintl=/usr \
		--with-readline=/usr \
		--with-sqlite3=/usr \
		--libexecdir=/usr/sbin \
		$(use_enable afs afs-support) \
		$(use_enable berkdb berkeley-db) \
		$(use_enable otp) \
		$(use_enable pkinit kx509) \
		$(use_enable pkinit pk-init) \
		$(use_enable threads pthread-support) \
		$(use_with hdb-ldap openldap /usr) \
		$(use_with ipv6) \
		$(use_with ssl openssl /usr) \
		$(use_with X x)
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_test() {
	einfo "Disabled check-iprop which is known to fail.  Other tests should work."
	default_src_test
}

src_install() {
	INSTALL_CATPAGES="no" emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog README NEWS TODO

	# Begin client rename and install
	for i in {telnetd,ftpd,rshd,popper}
	do
		mv "${D}"/usr/share/man/man8/{,k}${i}.8
		mv "${D}"/usr/sbin/{,k}${i}
	done

	for i in {rcp,rsh,telnet,ftp,su,login,pagsh,kf}
	do
		mv "${D}"/usr/share/man/man1/{,k}${i}.1
		mv "${D}"/usr/bin/{,k}${i}
	done

	mv "${D}"/usr/share/man/man5/{,k}ftpusers.5
	mv "${D}"/usr/share/man/man5/{,k}login.access.5

	newinitd "${FILESDIR}"/heimdal-kdc.initd heimdal-kdc
	newinitd "${FILESDIR}"/heimdal-kadmind.initd heimdal-kadmind
	newinitd "${FILESDIR}"/heimdal-kpasswdd.initd heimdal-kpasswdd
	newinitd "${FILESDIR}"/heimdal-kcm.initd heimdal-kcm

	insinto /etc
	newins "${FILESDIR}"/krb5.conf krb5.conf.example

	if use hdb-ldap; then
		insinto /etc/openldap/schema
		doins "${S}/lib/hdb/hdb.schema"
	fi

	# default database dir
	keepdir /var/heimdal
}

pkg_preinst() {

	if has_version "=${CATEGORY}/${PN}-1.3.2*" ; then
		if use hdb-ldap ; then
			ewarn "Schema name changed to hdb.schema to follow upstream."
			ewarn "Please check you slapd conf file to make sure"
			ewarn "that the correct schema file is included."
		fi
	fi
}
