# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vpopmail/vpopmail-5.2.1-r5.ebuild,v 1.3 2003/05/23 00:50:07 robbat2 Exp $

IUSE="mysql ipalias"

inherit eutils

# TODO: all ldap, sybase support
HOMEPAGE="http://www.inter7.com/vpopmail"
DESCRIPTION="A collection of programs to manage virtual email domains and accounts on your Qmail or Postfix mail servers."
SRC_URI="http://www.inter7.com/${PN}/${P}.tar.gz
	mysql? ( http://gentoo.twobit.net/misc/${P}-mysql.diff )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
DEPEND="sys-apps/sed
	sys-apps/ucspi-tcp
	mysql? ( >=dev-db/mysql-3.23* )"
RDEPEND="net-mail/qmail
	virtual/cron
	mysql? ( >=dev-db/mysql-3.23* )"

# Define vpopmail home dir in /etc/password if different
VPOP_DEFAULT_HOME="/var/vpopmail"
VPOP_HOME="$VPOP_DEFAULT_HOME"

# This makes sure the variable is set, and that it isn't null.
vpopmail_set_homedir() {
	VPOP_HOME=`grep vpopmail /etc/passwd | cut -d: -f6`
	if [ -z "$VPOP_HOME" ]; then
		echo -ne "\a"
	  eerror "vpopmail's home directory is null in /etc/passwd"
	  eerror "You probably want to check that out."
		eerror "Continuing with default."
		sleep 1; echo -ne "\a"; sleep 1; echo -ne "\a"
		VPOP_HOME="/var/vpopmail"
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
}

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz
	cd ${S}

	if [ "`use mysql`" ]; then
		einfo "Applying MySQL patch..."
		# Thanks to Nicholas Jones (carpaski@gentoo.org)
		epatch ${DISTDIR}/vpopmail-5.2.1-mysql.diff
	fi

	# Thanks to Vadim Berezniker (vadim@berezniker.com)
	# This patch backports a bug fix from the devel version re: logons
	epatch ${FILESDIR}/vpopmail.diff
}

src_compile() {
	vpopmail_set_homedir

	use ipalias && myopts="${myopts} --enable-ip-alias-domains=y" \
		|| myopts="${myopts} --enable-ip-alias-domains=n"

	use mysql && myopts="${myopts} --enable-mysql=y \
			--enable-libs=/usr/include/mysql \
			--enable-sqllibdir=/usr/lib/mysql \
			--enable-mysql-logging=y \
			--enable-auth-logging=y \
			--enable-valias=y \
			--enable-mysql-replication=n" \
		|| myopts="${myopts} --enable-mysql=n"
	
	# the configure script tries to force root and make directories not using ${D}
	sed -e '1282,1289d' -e '1560,1567d' -e '2349d' -e '2107d' -e '2342d' configure > configure.new
	mv --force configure.new configure
	chmod u+x configure

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
		--enable-clear-passwd=y \
		--enable-defaultquota=30000000,1000C \
		--enable-roaming-users=y --enable-relay-clear-minutes=60 \
		--enable-tcprules-prog=/usr/bin/tcprules --enable-tcpserver-file=/etc/tcp.smtp \
		--enable-logging=y \
		--enable-log-name=vpopmail

	[ "`use mysql`" ] && echo '#define MYSQL_PASSWORD_FILE "/etc/vpopmail.conf"' >> config.h

	emake || die "Make failed."
}

src_install () {
	vpopmail_set_homedir

	make DESTDIR=${D} install-strip || die

	# Install documentation.
	dodoc AUTHORS ChangeLog COPYING FAQ INSTALL NEWS TODO
	dodoc README README.* RELEASE.NOTES UPGRADE.*
	dodoc doc/doc_html/* doc/man_html/*
	rm -rf ${D}/${VPOP_HOME}/doc
	dosym /usr/share/doc/${PVR}/ ${VPOP_HOME}/doc
	chown vpopmail.vpopmail ${D}/${VPOP_HOME}/doc

	# Create symlink in /usr/bin for executables
	dodir /usr/bin/
	for item in `ls -1 ${D}${VPOP_HOME}/bin`; do dosym ${VPOP_HOME}/bin/${item} usr/bin/${item} ; done

	# Create /etc/vpopmail.conf
	[ "`use mysql`" ] && dodir /etc && cp ${FILESDIR}/vpopmail.conf ${D}/etc/

	# Configure b0rked. We'll do this manually
	echo "-I${VPOP_HOME}/include" > ${D}/${VPOP_HOME}/etc/inc_deps
	if [ "`use mysql`" ]; then
		echo "-L${VPOP_HOME}/lib -lvpopmail -L/usr/lib/mysql -lmysqlclient -lz" > ${D}/${VPOP_HOME}/etc/lib_deps
	else
		echo "-L${VPOP_HOME}/lib -lvpopmail" > ${D}/${VPOP_HOME}/etc/lib_deps
	fi
}

pkg_preinst() {
	vpopmail_set_homedir

	# Keep DATA
	touch ${VPOP_HOME}/domains/.keep

	# This is a workaround until portage handles binary packages+users better.
	pkg_setup
}

pkg_postinst() {
	einfo "Performing post-installation routines for ${P}."
	echo "40 * * * * /usr/bin/clearopensmtp 2>&1 > /dev/null" >> /var/spool/cron/crontabs/root

	if [ "`use mysql`" ]; then
		einfo ""
		einfo "You have 'mysql' turned on in your USE"
		einfo "Vpopmail needs a VALID MySQL USER. Let's call it 'vpopmail'"
		einfo "You MUST add it and then specify its passwd in the /etc/vpopmail.conf file"
		einfo ""
		einfo "First log into mysql as your mysql root user and pass. Then:"
		einfo "> create database vpopmail;"
		einfo "> use mysql;"
		einfo "> grant select, insert, update, delete, create, drop on vpopmail.* to"
		einfo "  vpopmail@localhost identified by 'your password';"
		einfo "> flush privileges;"
		einfo ""
	fi
}

pkg_postrm() {
	vpopmail_set_homedir

	sed "/^40.*\/usr\/bin\/clearopensmtp.*null$/d" /var/spool/cron/crontabs/root > /var/spool/cron/crontabs/root.new
	mv --force /var/spool/cron/crontabs/root.new /var/spool/cron/crontabs/root
	einfo "The vpopmail DATA will NOT be removed automatically."
	einfo "You can delete them manually by removing the ${VPOP_HOME} directory."
}
