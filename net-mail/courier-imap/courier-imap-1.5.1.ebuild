# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/courier-imap/courier-imap-1.5.1.ebuild,v 1.2 2002/08/14 12:05:25 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An IMAP daemon designed specifically for maildirs"
SRC_URI="http://ftp1.sourceforge.net/courier/${P}.tar.gz"
HOMEPAGE="http://www.courier-mta.org/"

KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

PROVIDE="virtual/imapd"
RDEPEND="virtual/glibc
	>=dev-libs/openssl-0.9.6
	pam? ( >=sys-libs/pam-0.75 )
	berkdb? ( >=sys-libs/db-3.2 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	mysql? ( >=dev-db/mysql-3.23.36 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	tcltk? ( >=dev-tcltk/expect-5.33.0 )"
DEPEND="${RDEPEND} sys-devel/perl sys-apps/procps"

# This package is complete if you just need basic IMAP functionality.
# Here are some things that still need fixing:
# o supervise support (of course)
# o tweaking of config files
# o My RC script is configured to look for maildirs in ~/.maildir
#     (my preference, and the official Gentoo Linux standard location)
#     instead of the more traditional and icky ~/Maildir.
# o We need to add an /etc/mail.conf.

src_compile() {
	local myconf
	use pam || myconf="${myconf} --without-authpam"
	use ldap || myconf="${myconf} --without-authldap"
	use mysql || myconf="${myconf} --without-authmysql"
	use berkdb && myconf="${myconf} --with-db=db"
	use berkdb || myconf="${myconf} --with-db=gdbm"
	use ipv6 || myconf="${myconf} --without-ipv6"

	./configure \
		--prefix=/usr \
		--bindir=/usr/sbin \
		--disable-root-check \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/courier-imap \
		--libexecdir=/usr/lib/courier-imap \
		--localstatedir=/var/lib/courier-imap \
		--enable-workarounds-for-imap-client-bugs \
		--with-authdaemonvar=/var/lib/courier-imap/authdaemon \
		--enable-unicode \
		--without-authvchkpw \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	# change the pem file location..
	cp imap/imapd-ssl.dist imap/imapd-ssl.dist.old
	sed -e "s:^\(TLS_CERTFILE=\).*:\1/etc/courier-imap/imapd.pem:" \
		imap/imapd-ssl.dist.old > imap/imapd-ssl.dist

	cp imap/pop3d-ssl.dist imap/pop3d-ssl.dist.old
	sed -e "s:^\(TLS_CERTFILE=\).*:\1/etc/courier-imap/pop3d.pem:" \
		imap/pop3d-ssl.dist.old > imap/pop3d-ssl.dist

	emake || die "compile problem"
}

src_install () {
	dodir /var/lib/courier-imap
	mkdir -p ${D}/etc/pam.d
	make install DESTDIR=${D}

	# avoid name collisions in /usr/sbin wrt imapd and pop3d
	cd ${D}/usr/sbin
	for name in imapd pop3d
	do
		mv ${name} "courier-${name}"
	done

	# hack /usr/lib/courier-imap/foo.rc to use ${MAILDIR} instead of
	# 'Maildir', and to use /usr/sbin/courier-foo names.
	cd ${D}/usr/lib/courier-imap
	local service
	for service in imapd pop3d
	do
		local type
		for type in "" "-ssl"
		do
			local file
			file="${service}${type}.rc"
			cp ${file} ${file}.orig
			sed -e 's/Maildir/${MAILDIR}/' \
			    -e "s/\/usr\/sbin\/${service}/\/usr\/sbin\/courier-${service}/" \
				${file}.orig > ${file}
		done
	done

	cd ${D}/etc/courier-imap
	local x
	for x in pop3d pop3d-ssl imapd imapd-ssl authdaemonrc
	do
		mv ${x}.dist ${x}
	done

	# add a value for ${MAILDIR} to /etc/courier-imap/imapd
	for service in imapd pop3d
	do
		echo -e '\n#Hardwire a value for ${MAILDIR}' >> ${service}
		echo 'MAILDIR=.maildir' >> ${service}
	done

	cd ${D}/usr/sbin
	for x in *
	do
		if [ -L ${x} ]
		then
			rm ${x}
		fi
	done

	cd ../share
	mv * ../sbin
        mv ../sbin/man .
	cd ..

	rm -f ${D}/usr/sbin/mkimapdcert ${D}/usr/sbin/mkpop3dcert
	exeinto /usr/sbin 
		doexe ${FILESDIR}/mkimapdcert ${FILESDIR}/mkpop3dcert

 	exeinto /etc/init.d
		newexe ${FILESDIR}/authdaemond.rc6 authdaemond
		newexe ${FILESDIR}/courier-imapd.rc6 courier-imapd
		newexe ${FILESDIR}/courier-imapd-ssl.rc6 courier-imapd-ssl
		newexe ${FILESDIR}/courier-pop3d.rc6 courier-pop3d
		newexe ${FILESDIR}/courier-pop3d-ssl.rc6 courier-pop3d-ssl

	exeinto /usr/lib/courier-imap
		doexe ${FILESDIR}/gentoo-imapd.rc ${FILESDIR}/gentoo-imapd-ssl.rc \
			${FILESDIR}/gentoo-pop3d.rc ${FILESDIR}/gentoo-pop3d-ssl.rc

	dodir /usr/bin
	mv ${D}/usr/sbin/maildirmake ${D}/usr/bin/maildirmake

	# courier-imap comes with pam_stack aware pam.d/ files already
	#insinto /etc/pam.d ; doins ${FILEDIR}/pam.d-imap
}

pkg_postinst() {
	# rebuild init deps to include deps on authdaemond
	/etc/init.d/depscan.sh
	echo
	einfo "Courier-IMAP version 1.4.5-r1 and higher have new init scripts."
	einfo "Please use courier-imapd instead of courier-imap."
	einfo "This release also includes support for the included pop3 server."
	einfo "If you choose not to switch your init files, you server will "
	einfo "continue to function as it currently does."
	echo
}
