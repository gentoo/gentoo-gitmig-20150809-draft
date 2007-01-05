# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/courier-imap/courier-imap-4.0.1.ebuild,v 1.11 2007/01/05 08:51:40 flameeyes Exp $

inherit eutils

DESCRIPTION="An IMAP daemon designed specifically for maildirs"
HOMEPAGE="http://www.courier-mta.org/"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
#MY_PV=${PV/_rc*/}
#SRC_URI=""http://www.courier-mta.org/beta/imap/${PN}-${MY_PV}.tar.bz2""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 mips ppc ~ppc64 s390 sh sparc x86"
IUSE="fam berkdb gdbm debug ipv6 nls selinux"
#userpriv breaks linking against vpopmail
RESTRICT="nouserpriv"

RDEPEND="virtual/libc
	>=dev-libs/openssl-0.9.6
	berkdb? ( sys-libs/db )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	fam? ( virtual/fam )
	selinux? ( sec-policy/selinux-courier-imap )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-lang/perl
	sys-process/procps
	>=net-libs/courier-authlib-0.50
	!mail-mta/courier"
PROVIDE="virtual/imapd"

#S=${WORKDIR}/${PN}-${MY_PV}
pkg_setup() {
	if ! use berkdb && ! use gdbm; then
		echo
		eerror "either 'berkdb' or 'gdbm' USE flag is required."
		eerror "please add it to '/etc/make.conf' or '/etc/portage/package.use'"
		eerror "'man 5 portage' for correct syntax usage for '/etc/postage/package.use'"
		echo
		die "required USE flag is missing."
	fi
}

vpopmail_setup() {
	VPOPMAIL_INSTALLED=
	VPOPMAIL_DIR=
	export VPOPMAIL_INSTALLED VPOPMAIL_DIR
	VPOPMAIL_DIR=`grep ^vpopmail /etc/passwd 2>/dev/null | cut -d: -f6`
	VPOPMAIL_INSTALLED=
	if has_version 'net-mail/vpopmail' && [ -n "${VPOPMAIL_DIR}" ] && [ -f "${VPOPMAIL_DIR}/etc/lib_deps" ]; then
		VPOPMAIL_INSTALLED=1
	else
		VPOPMAIL_DIR=
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# bug #48838. Patch to enable/disable FAM support.
	# 20 Aug 2004; langthang@gentoo.org.
	# This new patch should fix bug #51540. fam USE flag is not needed for shared folder support.
	epatch ${FILESDIR}/${P}-disable-fam-configure.in.patch || die "patch failed"

	# These patches should fix problem detecting Berkeley DB.
	# We now can compile with db4 support.
	if use berkdb; then
		epatch ${FILESDIR}/${P}-db4-bdbobj_configure.in.patch || die "patch failed"
		epatch ${FILESDIR}/${P}-db4-configure.in.patch || die "patch failed"
	fi

	export WANT_AUTOCONF="2.5"
	libtoolize --copy --force
	ebegin "Recreating configure"
	autoconf || \
		die "recreate configure failed"
	eend $?

	cd ${S}/maildir
	libtoolize --copy --force
	ebegin "Recreating maildir/configure"
	autoconf || \
		die "recreate configure failed"
	eend $?

	cd ${S}/bdbobj
	libtoolize --copy --force
	ebegin "Recreating bdbobj/configure"
		autoconf || \
		die "recreate configure failed"
	eend $?
}
src_compile() {
	vpopmail_setup

	local myconf
	myconf="$(use_with ipv6)"

	# 19 Aug 2004; langthang@gentoo.org
	# default to gdbm if both berkdb and gdbm present.
	if use gdbm; then
		einfo "build with GDBM support."
		myconf="${myconf} --with-db=gdbm"
	elif use berkdb; then
		einfo "build with Berkeley DB support."
		myconf="${myconf} --with-db=db"
	fi

	# This check should be in courier-authlib.
	# But I am not sure so I commented here
	# If you are using vpopmail and everything work,
	# please remove this section.
	#if [ -n "${VPOPMAIL_INSTALLED}" ]; then
	#	einfo "vpopmail found"
	#	myconf="${myconf} --with-authvchkpw"
	#	tmpLDFLAGS="$(cat ${VPOPMAIL_DIR}/etc/lib_deps)"
	#	LDFLAGS="${LDFLAGS} ${tmpLDFLAGS}"
	#	CFLAGS="${CFLAGS} $(cat ${VPOPMAIL_DIR}/etc/inc_deps)"
	#else
	#	einfo "vpopmail not found"
	#	myconf="${myconf} --without-authvchkpw"
	#fi

	# The default character set is ISO-8859-1/US-ASCII.
	# use nls will enable all available charater sets.
	# set ENABLE_UNICODE=iso-8859-1,utf-8,iso-8859-10
	# to include only specified translation table.
	if use nls && [ -z "$ENABLE_UNICODE" ]; then
		einfo "ENABLE_UNICODE is not set build with all availbale charater sets"
		myconf="${myconf} --enable-unicode"
	elif use nls; then
		einfo "ENABLE_UNICODE is not set build with unicode=$ENABLE_UNICODE"
		myconf="${myconf} --enable-unicode=$ENABLE_UNICODE"
	else
		einfo "disable unicode support"
		myconf="${myconf} --disable-unicode"
	fi

	use debug && myconf="${myconf} debug=true"

	# fix for bug #27528
	# they really should use a better way to detect redhat
	myconf="${myconf} --without-redhat"

	# bug #29879 - FAM support
	myconf="${myconf} $(use_with fam)"

	# bug #76592
	# configure cache confuses the configure script. 
	#local cachefile
	#cachefile=${WORKDIR}/config.cache
	#rm -f ${cachefile}

	# fix for bug #21330
	CFLAGS="$(echo ${CFLAGS} | xargs)"
	CXXFLAGS="$(echo ${CXXFLAGS} | xargs)"
	LDFLAGS="$(echo ${LDFLAGS} | xargs)"

	# fix for non-x86 platforms, bug #38606
	# courier-imap doesn't respect just --host=$CHOST without --build
	[ -z "${CBUILD}" ] && export CBUILD="${CHOST}"

	# Do the actual build now
	LDFLAGS="${LDFLAGS} " econf \
		--disable-root-check \
		--bindir=/usr/sbin \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/courier-imap \
		--libexecdir=/usr/$(get_libdir)/courier-imap \
		--localstatedir=/var/lib/courier-imap \
		--enable-workarounds-for-imap-client-bugs \
		--with-authdaemonvar=/var/lib/courier-imap/authdaemon \
		--with-mailuser=mail \
		--with-mailgroup=mail \
		${myconf} || die "econf failed"

	# change the pem file location..
	sed -e "s:^\(TLS_CERTFILE=\).*:\1/etc/courier-imap/imapd.pem:" \
		-i.orig imap/imapd-ssl.dist || \
		die "sed failed"

	sed -e "s:^\(TLS_CERTFILE=\).*:\1/etc/courier-imap/pop3d.pem:" \
		-i.orig imap/pop3d-ssl.dist || \
		die "sed failed"

	emake || die "compile problem"
}

src_install() {
	vpopmail_setup

	dodir /var/lib/courier-imap /etc/pam.d
	make install DESTDIR=${D} || die

	# avoid name collisions in /usr/sbin wrt imapd and pop3d
	cd ${D}/usr/sbin
	local name
	for name in imapd pop3d; do
		mv ${name} "courier-${name}" || \
			die "failed to mv $name to courier-${name}"
	done

	# hack /usr/lib/courier-imap/foo.rc to use ${MAILDIR} instead of
	# 'Maildir', and to use /usr/sbin/courier-foo names.
	cd ${D}/usr/$(get_libdir)/courier-imap
	local service
	for service in imapd pop3d; do
		local type
		for type in "" "-ssl"; do
			local file
			file="${service}${type}.rc"
			#cp ${file} ${file}.orig
			#sed -e 's/Maildir/${MAILDIR}/' \
			#    -e "s/\/usr\/sbin\/${service}/\/usr\/sbin\/courier-${service}/" \
			#	${file}.orig > ${file}
			sed -e 's/Maildir/${MAILDIR}/' \
				-e "s/\/usr\/sbin\/${service}/\/usr\/sbin\/courier-${service}/" \
				-i.orig ${file} || die "sed failed"
		done
	done

	local x
	for x in pop3d pop3d-ssl imapd imapd-ssl; do
		mv -v ${D}/etc/courier-imap/${x}.dist \
			${D}/etc/courier-imap/${x} || \
			die "failed to mv ${x}.dist to ${x}"
	done

	#insinto /etc/courier-imap
	#newins ${FILESDIR}/authdaemond.conf-3.0.4-r1 authdaemond.conf

	# add a value for ${MAILDIR} to /etc/courier-imap/imapd
	cd ${D}/etc/courier-imap
	for service in imapd pop3d; do
		echo -e '\n#Hardwire a value for ${MAILDIR}' >> ${service}
		echo 'MAILDIR=.maildir' >> ${service}
		echo 'MAILDIRPATH=.maildir' >> ${service}
		echo -e '#Put any program for ${PRERUN} here' >> ${service}
		echo 'PRERUN='>> ${service}
	done
	# upstream has an extra setting of MAILDIRPATH (it's already in the base files)
	for service in imapd-ssl pop3d-ssl; do
		echo -e '\n#Hardwire a value for ${MAILDIR}' >> ${service}
		echo 'MAILDIRPATH=.maildir' >> ${service}
	done

	cd ${D}/usr/sbin
	for x in *; do
		if [ -L ${x} ]; then
			rm -v ${x} || die "failed to rm ${x}"
		fi
	done

	cd ../share
	mv -v * ../sbin
	mv -v ../sbin/man .
	cd ..

	for x in mkimapdcert mkpop3dcert; do
		mv ${D}/usr/sbin/${x} ${D}/usr/sbin/${x}.orig || \
			die "failed to rm ${D}/usr/sbin/${x} ${D}/usr/sbin/${x}"
	done

	exeinto /usr/sbin
		doexe ${FILESDIR}/mkimapdcert ${FILESDIR}/mkpop3dcert || \
			die "doexe failed"

	dosym /usr/sbin/courierlogger /usr/$(get_libdir)/courier-imap/courierlogger || \
			die "dosym failed"

	exeinto /etc/init.d
		newexe ${FILESDIR}/${P}-courier-imapd.rc6 courier-imapd || die "newexe failed"
		newexe ${FILESDIR}/${P}-courier-imapd-ssl.rc6 courier-imapd-ssl || die "newexe failed"
		newexe ${FILESDIR}/${P}-courier-pop3d.rc6 courier-pop3d || die "newexe failed"
		newexe ${FILESDIR}/${P}-courier-pop3d-ssl.rc6 courier-pop3d-ssl || die "newexe failed"

	exeinto /usr/$(get_libdir)/courier-imap
		newexe ${FILESDIR}/${P}-gentoo-imapd.rc gentoo-imapd.rc || die "newexe failed"
		newexe ${FILESDIR}/${P}-gentoo-imapd-ssl.rc gentoo-imapd-ssl.rc || die "newexe failed"
		newexe ${FILESDIR}/${P}-gentoo-pop3d.rc gentoo-pop3d.rc || die "newexe failed"
		newexe ${FILESDIR}/${P}-gentoo-pop3d-ssl.rc gentoo-pop3d-ssl.rc || die "newexe failed"

	#local authmods
	#authmods="authsystem.passwd authcram authshadow authuserdb authpwd authtest authinfo authmksock authcustom authdaemontest"
	#use mysql && authmods="${authmods} authmysql"
	#use postgres && authmods="${authmods} authpgsql"
	#use pam && authmods="${authmods} authpam"
	#use ldap && authmods="${authmods} authldap"
	#[ -n "${VPOPMAIL_INSTALLED}" ] && authmods="${authmods} authvchkpw"
	#exeinto /usr/lib/courier-imap/authlib
	#for i in ${authmods}; do
	#	[ -f ${S}/authlib/${i} ] && doexe ${S}/authlib/${i} || die "doexe failed"
	#done;

	dodir /usr/bin
	mv ${D}/usr/sbin/maildirmake ${D}/usr/bin/maildirmake || \
		die "mv failed"

	# bug #45953, more docs
	cd ${S}
	dohtml -r ${S}/*
	dodoc ${S}/{00README.NOW.OR.SUFFER,AUTHORS,INSTALL,NEWS,README,ChangeLog} \
		${FILESDIR}/courier-imap-gentoo.readme
	docinto imap
	dodoc ${S}/imap/{ChangeLog,BUGS,BUGS.html,README}
	docinto maildir
	dodoc ${S}/maildir/{AUTHORS,INSTALL,README.maildirquota.txt,README.sharedfolders.txt}
	docinto tcpd
	dodoc ${S}/tcpd/README.couriertls
}

pkg_postinst() {
	einfo "Authdaemond is no longer provided this package."
	einfo "athentication libraries are from courier-authlib"
	einfo "for a quick start please refer to"
	einfo "/usr/share/doc/${P}/courier-imap-gentoo.readme.gz"
}

src_test() {
	ewarn "make check not supported by package due to"
	ewarn "--enable-workarounds-for-imap-client-bugs option."
}
