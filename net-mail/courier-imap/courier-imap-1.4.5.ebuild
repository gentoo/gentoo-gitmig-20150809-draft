# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/courier-imap/courier-imap-1.4.5.ebuild,v 1.1 2002/05/06 20:05:42 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An IMAP daemon designed specifically for maildirs"
SRC_URI="http://ftp1.sourceforge.net/courier/${P}.tar.gz"
HOMEPAGE="http://www.courier-mta.org/"

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
# o creation of imapd-ssl, pop3-ssl, pop3 init.d scripts
#     (I only converted the imapd.rc script)
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
		--host=${CHOST} ${myconf} || die "bad ./configure"

	# change the pem file location..
	cp imap/imapd-ssl.dist imap/imapd-ssl.dist.old
	sed -e "s:^\(TLS_CERTFILE=\).*:\1/etc/courier-imap/imapd.pem:" \
		imap/imapd-ssl.dist.old > imap/imapd-ssl.dist

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

	# we dont need to do this.. // woodchip
	#cd ${D}/etc/pam.d
	#for x in *
	#do
	#	cp ${x} ${x}.orig
	#	sed -e 's#/lib/security/##g' ${x}.orig > ${x}
	#	rm ${x}.orig
	#done

	rm ${D}/usr/sbin/mkimapdcert
	exeinto /usr/sbin ; doexe ${FILESDIR}/mkimapdcert

 	exeinto /etc/init.d
	newexe ${FILESDIR}/courier-imap-rc6 courier-imap
	newexe ${FILESDIR}/courier-imap-ssl-rc6 courier-imap-ssl

	# not neccesary, we now have pam_stack, and courier-imap
	# comes with pam_stack aware pam.d/ files already :) // woodchip
	#insinto /etc/pam.d ; doins ${FILEDIR}/pam.d-imap
}
