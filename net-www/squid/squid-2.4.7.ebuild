# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/squid/squid-2.4.7.ebuild,v 1.8 2003/12/14 23:19:22 spider Exp $

IUSE="snmp pam ldap debug"

# this could be cleaner..
MY_P=${PN}-2.4.STABLE7
S=${WORKDIR}/${MY_P}
DESCRIPTION="A caching web proxy, with advanced features"
HOMEPAGE="http://www.squid-cache.org/"
SRC_URI="ftp://ftp.squid-cache.org/pub/squid-2/STABLE/${MY_P}-src.tar.gz
	ftp://sunsite.auc.dk/pub/infosystems/squid/squid-2/STABLE/${MY_P}-src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

RDEPEND="pam? ( >=sys-libs/pam-0.72 )
	ldap? ( >=net-nds/openldap-2 )"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4.0.5
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	# see the tops of these patches for details..
	epatch ${FILESDIR}/${P}-debian.diff
	epatch ${FILESDIR}/${P}-gentoo.diff

	if [ -z "`use debug`" ]
	then
		sed -i 's%LDFLAGS="-g"%LDFLAGS=""%' configure.in
		autoconf || die
	fi
}

src_compile() {
	local myconf mymodules
	mymodules="getpwnam,YP,NCSA,SMB,MSNT,multi-domain-NTLM"
	use ldap && mymodules="LDAP,${mymodules}"
	use pam && mymodules="PAM,${mymodules}"
	use snmp && myconf="--enable-snmp"

	./configure \
		--prefix=/usr \
		--bindir=/usr/sbin \
		--exec-prefix=/usr \
		--sbindir=/usr/sbin \
		--localstatedir=/var \
		--sysconfdir=/etc/squid \
		--libexecdir=/usr/lib/squid \
		--enable-storeio="ufs,diskd,coss,aufs,null" \
		--enable-removal-policies="lru,heap" \
		--enable-auth-modules=${mymodules} \
		--enable-linux-netfilter \
		--disable-ident-lookups \
		--enable-useragent-log \
		--enable-cache-digests \
		--enable-delay-pools \
		--enable-referer-log \
		--enable-async-io \
		--enable-truncate \
		--enable-arp-acl \
		--with-pthreads \
		--enable-htcp \
		--enable-carp \
		--enable-poll \
		--host=${CHOST} ${myconf} || die "bad ./configure"
		#--enable-icmp

	mv include/autoconf.h include/autoconf.h.orig
	sed -e "s:^#define SQUID_MAXFD.*:#define SQUID_MAXFD 4096:" \
		include/autoconf.h.orig > include/autoconf.h

	emake || die "compile problem"
}

src_install() {
	make \
		prefix=${D}/usr \
		bindir=${D}/usr/sbin \
		localstatedir=${D}/var \
		sysconfdir=${D}/etc/squid \
		libexecdir=${D}/usr/lib/squid \
		install || die

	#make -C src install-pinger libexecdir=${D}/usr/lib/squid || die
	#chown root:squid ${D}/usr/lib/squid/pinger
	#chmod 4750 ${D}/usr/lib/squid/pinger

	mv ${D}/usr/sbin/{*_auth*,Run*} ${D}/usr/lib/squid
	chown root:squid ${D}/usr/lib/squid/pam_auth
	chmod 2750 ${D}/usr/lib/squid/pam_auth

	rm -rf ${D}/etc/squid/errors ${D}/var/logs
	cd errors
	dodir /usr/lib/squid/errors
	for i in *
	do
		if [ -d $i ]
		then
			insinto /usr/lib/squid/errors/$i
			doins $i/*
		fi
	done
	cd ${S}
	dosym /usr/lib/squid/errors/English /etc/squid/errors

	dodoc README QUICKSTART CONTRIBUTORS COPYRIGHT
	dodoc COPYING CREDITS ChangeLog TODO
	newdoc auth_modules/SMB/README SMB.auth.readme
	newdoc auth_modules/LDAP/README LDAP.auth.readme
	doman auth_modules/LDAP/*.8 doc/tree.3
	docinto txt
	dodoc doc/*.txt

	insinto /etc/pam.d ; newins ${FILESDIR}/squid.pam squid
	exeinto /etc/init.d ; newexe ${FILESDIR}/squid.rc6 squid
	insinto /etc/conf.d ; newins ${FILESDIR}/squid.confd squid
}

pkg_postinst() {
	# This helps if you had it installed, but never _ran_ it.
	install -m0755 -o squid -g squid -d ${ROOT}/var/cache/squid
	install -m0755 -o squid -g squid -d ${ROOT}/var/log/squid
}
