# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/cyrus-imapd/cyrus-imapd-2.1.5.ebuild,v 1.5 2002/08/08 15:29:01 raker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The Cyrus IMAP Server"
HOMEPAGE="http://asg.web.cmu.edu/cyrus/imapd/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

PROVIDE="virtual/imapd"
RDEPEND="virtual/glibc
	afs? ( >=net-fs/openafs-1.2.2 )
	snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	>=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/cyrus-sasl-2.1.2
	>=sys-apps/tcp-wrappers-7.6"
DEPEND="virtual/glibc
	afs? ( >=net-fs/openafs-1.2.2 )
	snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	>=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/cyrus-sasl-2.1.2
	>=sys-apps/tcp-wrappers-7.6"


# recommended: flex, maybe: net-snmp, postfix, perl?, afs, inn, tcl (cyradm)
	
pkg_setup() {
	
	if ! grep -q ^cyrus: /etc/passwd ; then
		useradd -c cyrus -d /usr/cyrus -g mail -s /bin/false -u 96 cyrus \
			|| die "problem adding user cyrus"
	fi
}

src_unpack() {

	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/e2fsprogs-et.diff
}

src_compile() {

	local myconf
	
	use afs || myconf="--without-afs"
	use snmp || myconf="${myconf} --without-ucdsnmp"
	use ssl || myconf="${myconf} --without-openssl"


	./configure \
		--prefix=/usr \
		--without-krb \
		--without-gssapi \
		--enable-listext \
		--disable-cyradm \
		--without-perl \
		--with-cyrus-user=cyrus \
		--with-cyrus-group=mail \
		--enable-shared \
		--enable-netscapehack \
		--with-com_err=yes \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	# make depends break with -f... in CFLAGS
	make depend CFLAGS="" || die "make depend problem"

	make || die "compile problem"

}

src_install () {

	emake DESTDIR=${D} install || die

	# Remove the developer stuff (-> dev-libs/cyrus-imap-devel)
	rm -rf ${D}usr/include ${D}usr/lib

	# Remove the manpages (wrong place)
	rm -rf ${D}usr/man
	
	mkdir ${D}etc
	cp ${FILESDIR}/imapd.conf ${D}etc/imapd.conf
	cp ${FILESDIR}/cyrus.conf ${D}etc/cyrus.conf
	mkdir ${D}etc/pam.d
	cp ${FILESDIR}/pam.d-imap ${D}etc/pam.d/imap

	mkdir ${D}var ${D}var/log
	touch ${D}var/log/imapd.log
	touch ${D}var/log/auth.log

   	mkdir -m 0750 ${D}var/imap
   	chown -R cyrus.mail ${D}var/imap 
   	mkdir -m 0755 ${D}var/imap/db
        chown -R cyrus.mail ${D}var/imap/db
   	mkdir -m 0755 ${D}var/imap/log
        chown -R cyrus.mail ${D}var/imap/log
   	mkdir -m 0755 ${D}var/imap/msg
        chown -R cyrus.mail ${D}var/imap/msg
   	mkdir -m 0755 ${D}var/imap/user
        chown -R cyrus.mail ${D}var/imap/user
	for i in a b c d e f g h i j k l m n o p q r s t u v w x y z ; do mkdir -m 0755 ${D}var/imap/user/$i ; \
	    chown -R cyrus.mail ${D}var/imap/user/$i ; done
   	mkdir -m 0755 ${D}var/imap/proc
        chown -R cyrus.mail ${D}var/imap/proc
   	mkdir -m 0755 ${D}var/imap/quota
	for i in a b c d e f g h i j k l m n o p q r s t u v w x y z ; do mkdir -m 0755 ${D}var/imap/quota/$i ; \
	    chown -R cyrus.mail ${D}var/imap/quota/$i ; done
	mkdir -m 0755 ${D}var/imap/sieve
        chown -R cyrus.mail ${D}var/imap/sieve
	for i in a b c d e f g h i j k l m n o p q r s t u v w x y z ; do mkdir -m 0755 ${D}var/imap/sieve/$i ; \
	    chown -R cyrus.mail ${D}var/imap/sieve/$i ; done
   	mkdir -m 0755 ${D}var/imap/socket
        chown -R cyrus.mail ${D}var/imap/socket

	mkdir ${D}var/spool
	mkdir -m 0750 ${D}var/spool/imap
        chown -R cyrus.mail ${D}var/spool/imap
	mkdir -m 0755 ${D}var/spool/imap/stage.
        chown -R cyrus.mail ${D}var/spool/imap/stage.
	# For hashimapspool
	for i in a b c d e f g h i j k l m n o p q r s t u v w x y z ; do mkdir -m 0755 ${D}var/spool/imap/$i ; \
	    chown -R cyrus.mail ${D}var/spool/imap/$i ; done


	doman man/*.?
	# remove man-pages from packet net-mail/cyrus-imapd-admin
	rm ${D}usr/share/man/man1/installsieve.1.gz ${D}usr/share/man/man1/sieveshell.1.gz

	dodoc COPYRIGHT README*
	dohtml doc/*.html doc/murder.png
	cp doc/cyrusv2.mc ${D}usr/share/doc/${PF}/html
	
	cp -r contrib tools ${D}usr/share/doc/${PF}
	# Remove the CVS directories
	find 2>/dev/null ${D}usr/share/doc/ -type d -name CVS -exec rm -rf '{}' \;

	exeinto /etc/init.d ; newexe ${FILESDIR}/cyrus.rc6 cyrus

}

pkg_postinst() {

	ewarn "*****************************************************************"
	ewarn "* WARNING: If you change the fs-type of /var/imap or            *"
	ewarn "* /var/spool/imap you should read step 9 of                     *"
	ewarn "* /usr/share/doc/${P}/html/install-configure.html. *"
	if df -T /var/imap | grep -q ' ext[23] ' ; then
		ewarn "* Setting /var/imap/user/* and /var/imap/quota/* to synchronous *"
		ewarn "* updates.                                                      *"
		chattr +S /var/imap/user /var/imap/user/* /var/imap/quota /var/imap/quota/*
	fi
	if df -T /var/spool/imap | grep -q ' ext[23] ' ; then
		ewarn "* Setting /var/spool/imap/* to synchronous updates.             *"
		chattr +S /var/spool/imap /var/spool/imap/*
	fi
	ewarn "* If the queue directory of the mail daemon resides on an ext2  *"
	ewarn "* or ext3 partition you need to set it manually to update       *"
	ewarn "* synchronously. E.g. 'chattr +S /var/spool/mqueue'.            *"
	ewarn "*****************************************************************"

	einfo "*****************************************************************"
	einfo "* NOTE: For correct logging add                                 *"
	einfo "*         local6.* /var/log/imapd.log                           *"
	einfo "*         auth.debug /var/log/auth.log                          *"
	einfo "*       to /etc/syslog.conf.                                     *"
	einfo "*****************************************************************"

	if [ "'use ssl'" ]; then
		ewarn "*****************************************************************"
		ewarn "* WARNING: Read the section about SSL and TLS of                *"
		ewarn "* /usr/share/doc/${P}/html/install-configure.html. *"
		ewarn "* about installing the needed keys.                             *"
		ewarn "*****************************************************************"
	fi

}
