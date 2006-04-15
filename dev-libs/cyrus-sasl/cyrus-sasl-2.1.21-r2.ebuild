# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cyrus-sasl/cyrus-sasl-2.1.21-r2.ebuild,v 1.9 2006/04/15 15:13:35 dertobi123 Exp $

inherit eutils gnuconfig flag-o-matic java-pkg multilib

ntlm_patch=${P}-ntlm_impl-spnego.patch.gz

DESCRIPTION="The Cyrus SASL (Simple Authentication and Security Layer)"
HOMEPAGE="http://asg.web.cmu.edu/sasl/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/${P}.tar.gz
	ntlm_unsupported_patch? ( mirror://gentoo/${ntlm_patch} )"

LICENSE="as-is"
SLOT="2"
KEYWORDS="alpha ~amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
# Removed 'static' USE flag because it is broken upstream, Bug #94137
IUSE="berkdb crypt gdbm ldap mysql postgres kerberos ssl java pam
		authdaemond sample urandom srp ntlm_unsupported_patch"

RDEPEND="virtual/libc
	berkdb? ( >=sys-libs/db-3.2 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	ldap? ( >=net-nds/openldap-2.0.25 )
	mysql? ( >=dev-db/mysql-3.23.51 )
	postgres? ( >=dev-db/postgresql-7.2 )
	pam? ( virtual/pam )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	kerberos? ( virtual/krb5 )
	authdaemond? (
		|| (
			>=net-mail/courier-imap-3.0.7
			>=mail-mta/courier-0.46
		)
	)
	java? ( virtual/jdk )
	ntlm_unsupported_patch? ( >=net-fs/samba-3.0.9 )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=sys-devel/autoconf-2.58
	sys-devel/automake
	sys-devel/libtool"

pkg_setup() {

	if use gdbm && use berkdb; then
		echo
		ewarn "You have both \"gdbm\" and \"berkdb\" in your USE flags."
		ewarn "Will default to GNU DB as your SASLdb database backend."
		ewarn "If you want to build with Berkeley DB support; hit Control-C now."
		ewarn "Change your USE flag -gdbm and emerge again."
		echo
		has_version ">=sys-apps/portage-2.0.50" && (
		einfo "It would be best practice to add the set of USE flags that you use for this"
		einfo "package to the file: /etc/portage/package.use. Example:"
		einfo "\`echo \"dev-libs/cyrus-sasl -gdbm berkdb\" >> /etc/portage/package.use\`"
		einfo "to build cyrus-sasl with Berkeley database as your SASLdb backend."
		)
		echo
		ewarn "Waiting 10 seconds before starting..."
		ewarn "(Control-C to abort)..."
		epause 10
	fi

	echo
	einfo "This version include a "-r" option for saslauthd to instruct it to reassemble"
	einfo "realm and username into a username of "user@realm" form."
	echo
	einfo "If you are still using postfix->sasl->saslauthd->pam->mysql for"
	einfo "authentication, please edit /etc/conf.d/saslauthd to read:"
	einfo "SASLAUTHD_OPTS=\"\${SASLAUTH_MECH} -a pam -r\""
	einfo "Don't forget to restart the service: \`/etc/init.d/saslauthd restart\`."
	echo
	einfo "Pause 10 seconds before continuing."
	epause 10
}

src_unpack() {
	unpack ${A} && cd "${S}"


	# Fix default port name for rimap auth mechanism.
	sed -e '/define DEFAULT_REMOTE_SERVICE/s:imap:imap2:' \
		-i saslauthd/auth_rimap.c || die "sed failed"

	# Add openldap 2.3 compile patch - bug #113914
	epatch "${FILESDIR}/${PN}-2.1.21-configure.patch"

	# Add configdir support.
	epatch "${FILESDIR}/${PN}-2.1.20-configdir.patch"

	# Fix include path for newer PostgreSQL versions.
	epatch "${FILESDIR}/${PN}-2.1.17-pgsql-include.patch"

	# Fix for gcc-4.0
	epatch "${FILESDIR}/${PN}-2.1.20-gcc4.patch"

	# UNSUPPORTED ntlm patch. Bug #81342
	use ntlm_unsupported_patch && epatch "${DISTDIR}/${ntlm_patch}"

	# Recreate configure.
	export WANT_AUTOCONF="2.5"
	rm -rf configure config.h.in autom4te.cache
	ebegin "Recreating configure"
	aclocal -I cmulocal -I config && autoheader && autoconf || \
		die "recreate configure failed"
	eend $?

	# Support for crypted passwords. Bug #45181
	use crypt && epatch "${FILESDIR}/cyrus-sasl-2.1.19-checkpw.c.patch"

	# Upstream doesn't even honor their own configure options... grumble
	sed -i 's:^sasldir = .*$:sasldir = $(plugindir):' ${S}/plugins/Makefile.{am,in}
}

src_compile() {
	local myconf="--enable-login --enable-ntlm --disable-krb4 --disable-otp"
#	myconf="${myconf} `use_enable static`" -- doesn't work upstream Bug #94137
	myconf="${myconf} `use_with ssl openssl`"
	myconf="${myconf} `use_with pam`"
	myconf="${myconf} `use_with ldap`"
	myconf="${myconf} `use_enable ldap ldapdb`"
	myconf="${myconf} `use_enable sample`"
	myconf="${myconf} `use_enable kerberos gssapi`"
	myconf="${myconf} `use_with mysql` `use_enable mysql`"
	myconf="${myconf} `use_with postgres pgsql` `use_enable postgres`"
	# Add use srp. Bug #81970.
	myconf="${myconf} `use_enable srp`"
	myconf="${myconf} `use_enable java` `use_with java javahome ${JAVA_HOME}`"
	# bug #56523. add authdaemond support.
	myconf="${myconf} `use_with authdaemond`"

	# fix for bug #59634. langthang 20040810.
	if ! use ssl; then
		myconf="${myconf} --without-des"
	fi

	if use mysql || use postgres ; then
		myconf="${myconf} --enable-sql"
	else
		myconf="${myconf} --disable-sql"
	fi

	# default to GDBM if both 'gdbm' and 'berkdb' present.
	if use gdbm; then
		einfo "build with GNU DB as database backend for your SASLdb."
		myconf="${myconf} --with-dblib=gdbm"
	elif use berkdb ; then
		einfo "build with Berkeley DB as database backend for your SASLdb."
		myconf="${myconf} --with-dblib=berkeley"
	else
		einfo "build without SASLdb support"
		myconf="${myconf} --with-dblib=none"
	fi

	# Use /dev/urandom instead of /dev/random. Bug #46038
	use urandom && myconf="${myconf} --with-devrandom=/dev/urandom"

	# Detect mips systems properly.
	gnuconfig_update

	econf \
		--with-saslauthd=/var/lib/sasl2 \
		--with-pwcheck=/var/lib/sasl2 \
		--with-configdir=/etc/sasl2 \
		--with-plugindir=/usr/$(get_libdir)/sasl2 \
		--with-dbpath=/etc/sasl2/sasldb2 \
		${myconf} || die "econf failed"

	# Upstream doesn't even honor their own configure options... grumble
	sed -i 's:^sasldir = .*$:sasldir = $(plugindir):' ${S}/plugins/Makefile

	einfo "build with MAKEOPTS=$MAKEOPTS"
	# we force -j1 for bug #110066
	emake -j1 || die "compile problem"

	# Bug #60769. Default location for java classes breaks OpenOffice.
	# Thanks to axxo@gentoo.org for the solution.
	cd "${S}"
	if use java; then
		jar -cvf ${PN}.jar -C java $(find java -name "*.class")
	fi

	# Bug #58768. Add testsaslauthd.
	cd "${S}/saslauthd"
	emake testsaslauthd || die "failed to make"
}

src_install () {
	#einstall
	make DESTDIR=${D} install || die "failed to install."
	keepdir /var/lib/sasl2 /etc/sasl2

	# Install everything necessary so user can build sample client/server
	# (bug #64733)
	if use sample; then
		insinto /usr/share/${PN}-2/examples
		doins aclocal.m4 config.h config.status configure.in
		dosym /usr/include/sasl /usr/share/${PN}-2/examples/include
		exeinto /usr/share/${PN}-2/examples
		doexe libtool
		insinto /usr/share/${PN}-2/examples/sample
		doins sample/*.{c,h} sample/*Makefile*
		insinto /usr/share/${PN}-2/examples/sample/.deps
		doins sample/.deps/*
		dodir /usr/share/${PN}-2/examples/lib
		dosym /usr/$(get_libdir)/libsasl2.la /usr/share/${PN}-2/examples/lib/libsasl2.la
		dodir /usr/share/${PN}-2/examples/lib/.libs
		dosym /usr/$(get_libdir)/libsasl2.so /usr/share/${PN}-2/examples/lib/.libs/libsasl2.so
	fi

	# Bug #60769. Default location for java classes breaks OpenOffice.
	if use java; then
		java-pkg_dojar ${PN}.jar
		#hackish, don't wanna dig though makefile
		rm -rf ${D}/usr/$(get_libdir)/java
		docinto java
		dodoc ${S}/java/README ${FILESDIR}/java.README.gentoo ${S}/java/doc/*
		mkdir ${D}/usr/share/doc/${PF}/java/Test/ \
			|| die "failed to create ${D}/usr/share/doc/${PF}/java/Test/"
		cp ${S}/java/Test/*.java ${D}/usr/share/doc/${PF}/java/Test/ \
			|| die "failed to copy java files to ${D}/usr/share/doc/${PF}/java/Test/"
	fi

	# Generate an empty sasldb2 with correct permissions.
	if use berkdb || use gdbm; then
		LD_OLD="${LD_LIBRARY_PATH}"
		export LD_LIBRARY_PATH="${D}/usr/$(get_libdir)" SASL_PATH="${D}/usr/$(get_libdir)/sasl2"
		echo "p" | "${D}/usr/sbin/saslpasswd2" -f "${D}/etc/sasl2/sasldb2" -p login
		"${D}/usr/sbin/saslpasswd2" -f "${D}/etc/sasl2/sasldb2" -d login
		export LD_LIBRARY_PATH="${LD_OLD}"
		chown root:mail "${D}/etc/sasl2/sasldb2"
		chmod 0640 "${D}/etc/sasl2/sasldb2"
	fi

	docinto ""
	dodoc AUTHORS COPYING ChangeLog NEWS README doc/TODO doc/*.txt
	newdoc pwcheck/README README.pwcheck
	dohtml doc/*.html

	docinto saslauthd
	dodoc saslauthd/{AUTHORS,COPYING,ChangeLog,LDAP_SASLAUTHD,NEWS,README}

	newpamd "${FILESDIR}/saslauthd.pam-include" saslauthd
	newinitd "${FILESDIR}/pwcheck.rc6" pwcheck || \
		die "failed to install pwcheck to /etc/init.d"
	newinitd "${FILESDIR}/saslauthd2.rc6" saslauthd || \
		die "failed to install saslauthd to /etc/init.d"
	newconfd "${FILESDIR}/saslauthd-${PV}.conf" saslauthd || \
		die "failed to install /etc/conf.d/saslauthd"

	exeinto ${ROOT}/usr/sbin
	newexe "${S}/saslauthd/testsaslauthd" testsaslauthd || \
		die "failed to install testsaslauthd."
}

pkg_postinst () {
	if use sample; then
		einfo "You have chosen to install sources for example client and server."
		einfo "To build these, please type:"
		einfo "\tcd /usr/share/${PN}-2/examples/sample && make"
	fi

	if use authdaemond; then
		ewarn "You need to add a user running a service using Courier's"
		ewarn "authdaemon to the 'mail' group. For example, do:"
		echo "	gpasswd -a postfix mail"
		ewarn "to add postfix to 'mail' group."
	fi
}
