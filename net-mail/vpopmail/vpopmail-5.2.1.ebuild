# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/vpopmail/vpopmail-5.2.1.ebuild,v 1.1 2002/07/24 10:49:23 carpaski Exp $

# TODO: all ldap, sybase support
S=${WORKDIR}/${P}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
HOMEPAGE="http://www.inter7.com/vpopmail"

DESCRIPTION="A collection of programs to manage virtual email domains and accounts on your Qmail or Postfix mail servers."
SRC_URI="http://www.inter7.com/vpopmail/${P}.tar.gz
	http://gentoo.twobit.net/misc/vpopmail-5.2.1-mysql.diff"

DEPEND="sys-apps/sed
	sys-apps/ucspi-tcp
	mysql? ( =dev-db/mysql-3.23* )"

RDEPEND="net-mail/qmail
	virtual/cron
	mysql? ( =dev-db/mysql-3.23* )"

pkg_setup() {
	if [ -z `getent group vchkpw` ]; then
		(groupadd -g 89 vchkpw 2>/dev/null || groupadd vchkpw ) || die "problem adding vchkpw group"
	fi    
	if [ -z `getent passwd vpopmail` ]; then
		( useradd -g vchkpw -u 89 -d /var/vpopmail -c "vpopmail_directory" -s /bin/false -m vpopmail || \
		 useradd -g vchkpw -u `getent group vchkpw | awk -F":" '{ print $3 }'` -d /var/vpopmail -c "vpopmail_directory" \
		 -s /bin/false -m vpopmail) || die "problem adding vpopmail user"
	fi

}

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.gz
	cd ${S}

	if [ "`use mysql`" ]; then
		einfo "Applying MySQL patch..."
	# Thanks to Nicholas Jones (carpaski@gentoo.org)
		patch < ${DISTDIR}/vpopmail-5.2.1-mysql.diff
	fi
}

src_compile() {

	use mysql \
		&& myopts="${myopts} --enable-mysql=y \
			--enable-libs=/usr/include/mysql \
			--enable-sqllibdir=/usr/lib/mysql \
			--enable-mysql-logging=y \
			--enable-auth-logging=y \
			--enable-valias=y \
			--enable-mysql-replication=n"

	econf ${myopts} --sbindir=/usr/sbin \
		--bindir=/usr/bin \
		--sysconfdir=/var/vpopmail/etc \
		--enable-qmaildir=/var/qmail \
		--enable-qmail-newu=/var/qmail/bin/qmail-newu \
		--enable-qmail-inject=/var/qmail/bin/qmail-inject \
		--enable-qmail-newmrh=/var/qmail/bin/qmail-newmrh \
		--enable-vpopuser=vpopmail \
		--enable-many-domains=y \
		--enable-vpopgroup=vchkpw \
		--enable-file-locking=y \
		--enable-file-sync=y \
		--enable-md5-passwords=y \
		--enable-clear-passwd=y \
		--enable-defaultquota=30000000,1000C \
		--enable-roaming-users=y --enable-relay-clear-minutes=60 \
		--enable-tcprules-prog=/usr/bin/tcprules --enable-tcpserver-file=/etc/tcp.smtp \
		--enable-logging=y \
		--enable-log-name=vpopmail || die "./configure failed"

	if [ "`use mysql`" ]; then
		echo '#define MYSQL_PASSWORD_FILE "/etc/vpopmail.conf"' >> config.h
	fi

	emake || die "Make failed."

}

src_install () {

	make DESTDIR=${D} install-strip || die
	touch ${D}/var/vpopmail/domains/.keep
	# Install documentation.
	dodoc AUTHORS ChangeLog COPYING FAQ INSTALL NEWS TODO README README.* RELEASE.NOTES UPGRADE.*

	# Create symlink in /usr/bin for executables
	mkdir -p ${D}/usr/bin/
	for item in `ls -1 ${D}/var/vpopmail/bin`; do dosym /var/vpopmail/bin/${item} usr/bin/${item} ; done

	# Create /etc/vpopmail.conf
	[ "`use mysql`" ] && mkdir ${D}/etc && cp ${FILESDIR}/vpopmail.conf ${D}/etc/

}

pkg_postinst() {

	einfo "Performing post-installation routines for ${P}."
	echo "40 * * * * /usr/bin/clearopensmtp 2>&1 > /dev/null" >> /var/spool/cron/crontabs/root

	# This is to let users to to their binary pkg. this is a workaround until portage will handle this in a better way
	if [ -z `getent group vchkpw` ]; then
		(groupadd -g 89 vchkpw 2>/dev/null || groupadd vchkpw ) || die "problem adding vchkpw group"
	fi
	if [ -z `getent passwd vpopmail` ]; then
		( useradd -g vchkpw -u 89 -d /var/vpopmail -c "vpopmail_directory" -s /bin/false -m vpopmail || \
		useradd -g vchkpw -u `getent group vchkpw | awk -F":" '{ print $3 }'` -d /var/vpopmail -c "vpopmail_directory" \
		-s /bin/false -m vpopmail) || die "problem adding vpopmail user"
	fi

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
	sed "/^40.*\/usr\/bin\/clearopensmtp.*null$/d" /var/spool/cron/crontabs/root > /var/spool/cron/crontabs/root.new
	mv --force /var/spool/cron/crontabs/root.new /var/spool/cron/crontabs/root
	einfo "The vpopmail DATA will NOT be removed automatically."
	einfo "You can delete them manually by removing the /var/vpopmail directory."
}
