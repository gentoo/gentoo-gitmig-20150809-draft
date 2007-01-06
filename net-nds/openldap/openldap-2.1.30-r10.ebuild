# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.1.30-r10.ebuild,v 1.1 2007/01/06 15:09:42 jokey Exp $

WANT_AUTOMAKE="1.9"
WANT_AUTOCONF="2.5"
AT_M4DIR="./build"
inherit autotools eutils

DESCRIPTION="LDAP suite of application and development tools"
HOMEPAGE="http://www.OpenLDAP.org/"
SRC_URI="mirror://openldap/openldap-release/${P}.tgz"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="berkdb crypt debug gdbm ipv6 odbc perl readline samba sasl slp ssl tcpd selinux"

# note that the 'samba' USE flag pulling in OpenSSL is NOT an error.  OpenLDAP
# uses OpenSSL for LanMan/NTLM hashing (which is used in some enviroments, like
# mine at work)!
# Robin H. Johnson <robbat2@gentoo.org> March 8, 2004

DEPEND=">=sys-libs/ncurses-5.1
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	sasl? ( >=dev-libs/cyrus-sasl-2.1.7-r3 )
	odbc? ( dev-db/unixODBC )
	slp? ( >=net-libs/openslp-1.0 )
	perl? ( >=dev-lang/perl-5.6 )
	samba? ( >=dev-libs/openssl-0.9.6 )
	berkdb? ( >=sys-libs/db-4.1.25_p1-r3 )
	!berkdb? (
		gdbm? ( >=sys-libs/gdbm-1.8.0 )
		!gdbm? ( >=sys-libs/db-4.1.25_p1-r3 )
	)"

RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-openldap )"

pkg_setup() {
	if has_version "<=dev-lang/perl-5.8.8_rc1" && built_with_use dev-lang/perl minimal ; then
		die "You must have a complete (USE='-minimal') Perl install to use the perl backend!"
	fi

	enewgroup ldap 439
	enewuser ldap 439 -1 /usr/lib/openldap ldap
}

src_unpack() {
	unpack ${A}

	# According to MDK, the link order needs to be changed so that
	# on systems w/ MD5 passwords the system crypt library is used
	# (the net result is that "passwd" can be used to change ldap passwords w/
	#  proper pam support)
	sed -ie 's/$(SECURITY_LIBS) $(LDIF_LIBS) $(LUTIL_LIBS)/$(LUTIL_LIBS) $(SECURITY_LIBS) $(LDIF_LIBS)/' \
		"${S}"/servers/slapd/Makefile.in

	# Fix up DB-4.0 linking problem
	# remember to autoconf! this expands configure by 500 lines (4 lines to m4
	# stuff).
	epatch "${FILESDIR}"/${PN}-2.1.30-db40.patch
	epatch "${FILESDIR}"/${PN}-2.1.30-tls-activedirectory-hang-fix.patch

	# Security bug #96767
	# http://bugzilla.padl.com/show_bug.cgi?id=210
	EPATCH_OPTS="-p1 -d ${S}" epatch "${FILESDIR}"/${PN}-2.2.26-tls-fix-connection-test.patch

	# supersedes old fix for bug #31202
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.1.27-perlthreadsfix.patch

	# fix up stuff for newer autoconf that simulates autoconf-2.13, but doesn't
	# do it perfectly.
	cd "${S}"/build
	ln -s shtool install
	ln -s shtool install.sh

	# ximian connector 1.4.7 ntlm patch
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.1.30-ximian_connector.patch

	#make files ready for new autoconf
	EPATCH_OPTS="-p0 -d ${S}" epatch "${FILESDIR}"/${PN}-2.1.30-autoconf25.patch

	# fix AC calls bug #114544
	EPATCH_OPTS="-p0 -d ${S}/build" epatch "${FILESDIR}"/${PN}-2.1.30-m4_underquoted.patch

	# make tests rpath ready
	EPATCH_OPTS="-p0 -d ${S}/tests" epatch "${FILESDIR}"/${PN}-2.1.30-tests.patch

	# make autoconf-archive compatible
	EPATCH_OPTS="-p0 -d ${S}" epatch "${FILESDIR}"/${PN}-2.1.30-autoconf-archived-fix.patch

	# CVE-2006-5779, bug #154349
	EPATCH_OPTS="-p0 -d ${S}" epatch "${FILESDIR}"/${PN}-2.3.27-CVE-2006-5779.patch

	# reconf current for RPATH solve
	libtoolize --copy --force
	eaclocal || die "aclocal failed"
	EPATCH_OPTS="-p0 -d ${S}" epatch "${FILESDIR}"/${PN}-2.1.30-rpath.patch
	eautoconf || die "autoconf failed"
}

src_compile() {
	local myconf

	# enable debugging to syslog
	use debug && myconf="${myconf} --enable-debug"
	myconf="${myconf} --enable-syslog"

	# enable slapd/slurpd servers
	myconf="${myconf} --enable-ldap"
	myconf="${myconf} --enable-slapd --enable-slurpd"

	myconf="${myconf} `use_enable crypt`"
	myconf="${myconf} `use_enable ipv6`"
	myconf="${myconf} `use_with sasl cyrus-sasl` `use_enable sasl spasswd`"
	myconf="${myconf} `use_with readline`"
	myconf="${myconf} `use_with ssl tls` `use_with samba lmpasswd`"
	myconf="${myconf} `use_enable tcpd wrappers`"
	myconf="${myconf} `use_enable odbc sql`"
	myconf="${myconf} `use_enable perl`"
	myconf="${myconf} `use_enable slp`"

	myconf="${myconf} --enable-ldbm"
	myconf_berkdb='--enable-bdb --with-ldbm-api=berkeley'
	myconf_gdbm='--disable-bdb --with-ldbm-api=gdbm'
	if use berkdb; then
		einfo "Using Berkeley DB for local backend"
		myconf="${myconf} ${myconf_berkdb}"
	elif use gdbm; then
		einfo "Using GDBM for local backend"
		myconf="${myconf} ${myconf_gdbm}"
	else
		ewarn "Neither gdbm or berkdb USE flags present, falling back to"
		ewarn "Berkeley DB for local backend"
		myconf="${myconf} ${myconf_berkdb}"
	fi
	myconf="${myconf} --enable-dynamic --enable-modules"
	myconf="${myconf} --enable-rewrite --enable-rlookups"
	myconf="${myconf} --enable-passwd --enable-phonetic"
	myconf="${myconf} --enable-dnssrv --enable-ldap"
	myconf="${myconf} --enable-meta --enable-monitor"
	myconf="${myconf} --enable-null --enable-shell"
	myconf="${myconf} --enable-local --enable-proctitle"

	econf \
		--enable-static \
		--enable-shared \
		--libexecdir=/usr/lib/openldap \
		${myconf} || die "configure failed"

	# Adding back -j1 as upstream didn't answer on parallel make issue yet
	emake -j1 depend || die "make depend failed"
	emake -j1 || die "make failed"
}

src_test() {
	einfo "Doing tests"
	cd tests ; make tests || die "make tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc ANNOUNCEMENT CHANGES COPYRIGHT README LICENSE "${FILESDIR}"/DB_CONFIG.fast.example
	docinto rfc ; dodoc doc/rfc/*.txt

	# make state directories
	for x in data slurp ldbm; do
		keepdir /var/lib/openldap-${x}
		fowners ldap:ldap /var/lib/openldap-${x}
		fperms 0700 /var/lib/openldap-${x}
	done

	# manually remove /var/tmp references in .la
	# because it is packaged with an ancient libtool
	for x in "${D}"usr/lib/lib*.la; do
		sed -i -e "s:-L${S}[/]*libraries::" ${x}
	done

	# change slapd.pid location in configuration file
	keepdir /var/run/openldap
	fowners ldap:ldap /var/run/openldap
	fperms 0755 /var/run/openldap
	for f in etc/openldap/slapd.conf etc/openldap/slapd.conf.default; do
		sed -e "s:/var/lib/slapd.:/var/run/openldap/slapd.:" -i "${D}"${f}
		sed -e "/database\tbdb$/acheckpoint	32	30 # <kbyte> <min>" -i "${D}"${f}
		fowners root:ldap ${f}
		fperms 0640 ${f}
	done

	# install our own init scripts
	newinitd "${FILESDIR}"/2.0/slapd slapd
	newinitd "${FILESDIR}"/2.0/slurpd slurpd
	newconfd "${FILESDIR}"/2.0/slapd.conf slapd
}

pkg_postinst() {
	if use ssl; then
		insinto /etc/openldap/ssl
		docert ldap
	fi

	# Since moving to running openldap as user ldap there are some
	# permissions problems with directories and files.
	# Let's make sure these permissions are correct.
	chown ldap:ldap "${ROOT}"var/run/openldap
	chmod 0755 "${ROOT}"var/run/openldap
	chown root:ldap "${ROOT}"etc/openldap/slapd.conf
	chmod 0640 "${ROOT}"etc/openldap/slapd.conf
	chown root:ldap "${ROOT}"etc/openldap/slapd.conf.default
	chmod 0640 "${ROOT}"etc/openldap/slapd.conf.default
	chown ldap:ldap "${ROOT}"var/lib/openldap-{data,ldbm,slurp}

	# notes from bug #41297, bug #41039
	if use ssl; then
		ewarn "- Self-signed SSL certificates are treated harshly by OpenLDAP 2.1"
		ewarn "  add 'TLS_REQCERT never' if you want to use them."
	fi

	# Reference inclusion bug #77330
	echo
	einfo "Getting started using OpenLDAP? There is some documentation available:"
	einfo "Gentoo Guide to OpenLDAP Authentication"
	einfo "(http://www.gentoo.org/doc/en/ldap-howto.xml)"

	# note to bug #110412
	echo
	einfo "An example file for tuning BDB backends with openldap is:"
	einfo "/usr/share/doc/${P}/DB_CONFIG.fast.example.gz"
}
