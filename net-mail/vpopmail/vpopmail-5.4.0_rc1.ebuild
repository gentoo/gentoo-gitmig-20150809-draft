# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vpopmail/vpopmail-5.4.0_rc1.ebuild,v 1.4 2004/02/15 22:56:28 robbat2 Exp $

IUSE="mysql ipalias clearpasswd"

inherit eutils gnuconfig fixheadtails

# TODO: all ldap, sybase support
HOMEPAGE="http://www.inter7.com/vpopmail"
DESCRIPTION="A collection of programs to manage virtual email domains and accounts on your Qmail or Postfix mail servers."
MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	mysql? ( http://gentoo.twobit.net/misc/${PN}-5.2.1-mysql.diff )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
DEPEND_COMMON="net-mail/qmail
	mysql? ( >=dev-db/mysql-3.23* )"
DEPEND="sys-apps/sed
		sys-apps/ucspi-tcp
		${DEPEND_COMMON}"
RDEPEND="${DEPEND_COMMON}
	 	 virtual/cron"
S="${WORKDIR}/${MY_P}"

# Define vpopmail home dir in /etc/password if different
VPOP_DEFAULT_HOME="/var/vpopmail"
VPOP_HOME="$VPOP_DEFAULT_HOME"

# This makes sure the variable is set, and that it isn't null.
vpopmail_set_homedir() {
	VPOP_HOME=`getent passwd vpopmail | cut -d: -f6`
	if [ -z "$VPOP_HOME" ]; then
		echo -ne "\a"
		eerror "vpopmail's home directory is null in passwd data!"
		eerror "You probably want to check that out."
		eerror "Continuing with default."
		sleep 1; echo -ne "\a"; sleep 1; echo -ne "\a"
		VPOP_HOME="${VPOP_DEFAULT_HOME}"
	else
		einfo "Setting VPOP_HOME to: $VPOP_HOME"
	fi
}

pkg_setup() {
	if [ -z `getent group vpopmail` ]; then
		(groupadd -g 89 vpopmail 2>/dev/null || groupadd vpopmail ) || die "problem adding vpopmail group"
	fi
	if [ -z `getent passwd vpopmail` ]; then
		useradd -g vpopmail -u 89 -d ${VPOP_DEFAULT_HOME} -c "vpopmail_directory" -s /bin/false -m vpopmail || \
		useradd -g vpopmail -u `getent group vpopmail | awk -F":" '{ print $3 }'` -d ${VPOP_DEFAULT_HOME} -c "vpopmail_directory" \
		-s /bin/false -m vpopmail || die "problem adding vpopmail user"
	fi
	upgradewarning
}

src_unpack() {
	cd ${WORKDIR}
	unpack ${MY_P}.tar.gz
	cd ${S}

	epatch ${FILESDIR}/vpopmail-5.2.1-showall.patch

	sed -i \
		's|Maildir|.maildir|g' \
		vchkpw.c vconvert.c vdelivermail.c \
		vpopbull.c vpopmail.c vqmaillocal.c \
		vuserinfo.c maildirquota.c \
		|| die "failed to change Maildir to .maildir"
	sed -i \
		'/printf.*vpopmail/s:vpopmail (:(:' \
		vdelivermail.c vpopbull.c vqmaillocal.c \
		|| die "failed to remove vpopmail advertisement"

	gnuconfig_update
	ht_fix_file ${S}/cdb/Makefile
}

src_compile() {
	vpopmail_set_homedir
	addpredict /var/vpopmail/etc/lib_deps
	addpredict /var/vpopmail/etc/inc_deps

	use ipalias && myopts="${myopts} --enable-ip-alias-domains=y" \
		|| myopts="${myopts} --enable-ip-alias-domains=n"

	use mysql && myopts="${myopts} --enable-auth-module=mysql \
			--enable-libs=/usr/include/mysql \
			--enable-sqllibdir=/usr/lib/mysql \
			--enable-mysql-logging=y \
			--enable-auth-logging=y \
			--enable-valias=y \
			--enable-mysql-replication=n \
			--enable-mysql-limits" \
		|| myopts="${myopts} --enable-mysql=n"

	# Bug 20127
	use clearpasswd &&
		myopts="${myopts} --enable-clear-passwd=y" ||
		myopts="${myopts} --enable-clear-passwd=n"

	econf ${myopts} --sbindir=/usr/sbin \
		--bindir=/usr/bin \
		--sysconfdir=${VPOP_HOME}/etc \
		--enable-qmaildir=/var/qmail \
		--enable-qmail-newu=/var/qmail/bin/qmail-newu \
		--enable-qmail-inject=/var/qmail/bin/qmail-inject \
		--enable-qmail-newmrh=/var/qmail/bin/qmail-newmrh \
		--enable-vpopuser=vpopmail \
		--enable-many-domains=y \
		--enable-vpopgroup=vpopmail \
		--enable-file-locking=y \
		--enable-file-sync=y \
		--enable-md5-passwords=y \
		--enable-defaultquota=30000000,1000C \
		--enable-logging=y \
		--enable-log-name=vpopmail \
		--enable-qmail-ext \
		--enable-domainquotas \
		--disable-tcp-rules-prog --disable-tcpserver-file --disable-roaming-users

	# TCPRULES for relaying is now considered obsolete, use relay-ctrl instead
	#--enable-tcprules-prog=/usr/bin/tcprules --enable-tcpserver-file=/etc/tcp.smtp \
	#--enable-roaming-users=y --enable-relay-clear-minutes=60 \
	#--disable-rebuild-tcpserver-file \


	# fix some borkage
	sed -re 's:(/var/vpopmail/etc/inc_deps):$(DESTDIR)/\1:g' -i ${S}/Makefile || die "failed to fix"
	sed -re 's:(/var/vpopmail/etc/lib_deps):$(DESTDIR)/\1:g' -i ${S}/Makefile || die "failed to fix"
	if use mysql; then
		sed -re 's:@USE_MYSQL@:"1":g' -i ${S}/Makefile || die "failed to fix"
	else
		sed -re 's:@USE_MYSQL@:"0":g' -i ${S}/Makefile || die "failed to fix"
	fi

	emake || die "Make failed."
}

src_install () {
	vpopmail_set_homedir

	make DESTDIR=${D} install || die

	into /var/vpopmail
	dobin ${FILESDIR}/vpopmail-Maildir-dotmaildir-fix.sh
	into /usr

	# Install documentation.
	dodoc AUTHORS ChangeLog COPYING FAQ INSTALL NEWS TODO
	dodoc README* RELEASE.NOTES UPGRADE.*
	dodoc doc/doc_html/* doc/man_html/*
	rm -rf ${D}/${VPOP_HOME}/doc
	dosym /usr/share/doc/${PF}/ ${VPOP_HOME}/doc

	# Create /etc/vpopmail.conf
	if use mysql; then
		einfo "Installing vpopmail mysql configuration file"
		dodir /etc
		#config file position
		mv ${D}/var/vpopmail/etc/vpopmail.mysql ${D}/etc/vpopmail.conf
		dosym /etc/vpopmail.conf /var/vpopmail/etc/vpopmail.mysql
		sed -e '12d' -i ${D}/etc/vpopmail.conf
		echo '# Read-only DB' >>${D}/etc/vpopmail.conf
		echo 'localhost|0|vpopmail|secret|vpopmail' >>${D}/etc/vpopmail.conf
		echo '# Write DB' >>${D}/etc/vpopmail.conf
		echo 'localhost|0|vpopmail|secret|vpopmail' >>${D}/etc/vpopmail.conf
		# lock down perms
		fperms 640 /etc/vpopmail.conf
		fowners root:vpopmail /etc/vpopmail.conf
	fi

	# Install a proper cronjob instead of the old nastiness
	#einfo "Installing cronjob"
	#dodir /etc/cron.hourly
	#insinto /etc/cron.hourly
	#doins ${FILESDIR}/vpopmail.clearopensmtp
	#fperms +x /etc/cron.hourly/vpopmail.clearopensmtp

	einfo "Installing env.d entry"
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/99vpopmail

	# Configure b0rked. We'll do this manually
	#echo "-I${VPOP_HOME}/include" > ${D}/${VPOP_HOME}/etc/inc_deps
	#local libs_extra
	#use mysql && libs_extra="-L/usr/lib/mysql -lmysqlclient -lz" || libs_extra=""
	#echo "-L${VPOP_HOME}/lib -lvpopmail ${libs_extra}" > ${D}/${VPOP_HOME}/etc/lib_deps

	einfo "Locking down vpopmail permissions"
	# secure things more, i don't want the vpopmail user being able to write this stuff!
	chown -R root:root ${D}${VPOP_HOME}/{bin,etc,include}

}

pkg_preinst() {
	vpopmail_set_homedir

	# Keep DATA
	keepdir ${VPOP_HOME}/domains

	# This is a workaround until portage handles binary packages+users better.
	pkg_setup

	upgradewarning
}

pkg_postinst() {
	einfo "Performing post-installation routines for ${P}."

	if use mysql; then
		echo
		einfo "You have 'mysql' turned on in your USE"
		einfo "Vpopmail needs a VALID MySQL USER. Let's call it 'vpopmail'"
		einfo "You MUST add it and then specify its passwd in the /etc/vpopmail.conf file"
		echo
		einfo "First log into mysql as your mysql root user and pass. Then:"
		einfo "> create database vpopmail;"
		einfo "> use mysql;"
		einfo "> grant select, insert, update, delete, create, drop on vpopmail.* to"
		einfo "  vpopmail@localhost identified by 'your password';"
		einfo "> flush privileges;"
		echo
		einfo "If you have problems with vpopmail not accepting mail properly,"
		einfo "please ensure that /etc/vpopmail.conf is chmod 640 and"
		einfo "owned by root:vpopmail"
	fi
	# do this for good measure
	if [ -e /etc/vpopmail.conf ]; then
		chmod 640 /etc/vpopmail.conf
		chown root:vpopmail /etc/vpopmail.conf
	fi

	upgradewarning
}

pkg_postrm() {
	vpopmail_set_homedir

	einfo "The vpopmail DATA will NOT be removed automatically."
	einfo "You can delete them manually by removing the ${VPOP_HOME} directory."
}

upgradewarning() {
	ewarn "Massive important warning if you are upgrading to 5.2.1-r8 or older"
	ewarn "The internal structure of the mail storage has changed for"
	ewarn "consistancy with the rest of Gentoo! Please review and utilize the "
	ewarn "script at /var/vpopmail/bin/vpopmail-Maildir-dotmaildir-fix.sh"
	ewarn "to upgrade your system! (It can do conversions both ways)."
	ewarn "You should be able to run it right away without any changes."
	echo
	einfo "Use of vpopmail's tcp.smtp[.cdb] is also deprecated now, consider"
	einfo "using net-mail/relay-ctrl instead."
}
