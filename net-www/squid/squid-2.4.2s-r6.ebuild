# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/squid/squid-2.4.2s-r6.ebuild,v 1.3 2001/12/23 23:25:19 azarah Exp $

DESCRIPTION="A caching web proxy, with advanced features"
HOMEPAGE="http://www.squid-cache.org/"

P=squid-2.4.STABLE2
S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.squid-cache.org/pub/squid-2/STABLE/${P}-src.tar.gz
	ftp://sunsite.auc.dk/pub/infosystems/squid/squid-2/STABLE/${P}-src.tar.gz"

RDEPEND="virtual/glibc
	ldap? ( >=net-nds/openldap-1.2.11 )
	pam? ( >=sys-libs/pam-0.72 )"
DEPEND="$RDEPEND sys-devel/perl"


src_unpack() {

	unpack ${A} ; cd ${S}

	# lots of nice patches, thanks debian ;)
	patch -p1 < ${FILESDIR}/squid-2.4.2s-debian.diff || die
	# gentoo patches: cachedir/logfile/error/icon locs, user/group
	patch -p1 < ${FILESDIR}/squid-2.4.2s-gentoo.diff || die
}

src_compile() {

	local myconf mymodules="getpwnam,YP,NCSA,SMB"
	use pam && mymodules="PAM,${mymodules}"
	use ldap && mymodules="LDAP,${mymodules}"
	use snmp && myconf="--enable-snmp"

	./configure \
	--prefix=/ \
	--bindir=/usr/sbin \
	--exec-prefix=/usr \
	--localstatedir=/var \
	--sysconfdir=/etc/squid \
	--libexecdir=/usr/lib/squid \
	--enable-auth-modules=${mymodules} \
	--enable-storeio="ufs,diskd,coss,aufs,null" \
	--enable-removal-policies="lru,heap" \
	--enable-linux-netfilter \
	--disable-ident-lookups \
	--enable-useragent-log \
	--enable-delay-pools \
	--enable-referer-log \
	--enable-truncate \
	--enable-arp-acl \
	--with-pthreads \
	--enable-htcp \
	--enable-carp \
	--enable-icmp \
	--host=${CHOST} ${myconf} || die

	make || die "compile problem :("
}

src_install() {

	make \
	prefix=${D}/usr \
	bindir=${D}/usr/sbin \
	localstatedir=${D}/var \
	sysconfdir=${D}/etc/squid \
	libexecdir=${D}/usr/lib/squid \
	install || die

	make -C src install-pinger libexecdir=${D}/usr/lib/squid || die

	# We need to do this after install, else it gets removed again
	dodir /var/log /var/spool
	diropts -m 770 -o root -g squid ; dodir /var/log/squid
	diropts -m 770 -o root -g squid ; dodir /var/spool/squid
			

	# some cleanup action
	mv ${D}/usr/sbin/*_auth* ${D}/usr/lib/squid
	mv ${D}/etc/squid/errors ${D}/usr/lib/squid

	# pinger needs root to bind to privelaged ports
	chown root.squid ${D}/usr/lib/squid/pinger
	chmod 4750 ${D}/usr/lib/squid/pinger
	# pam_auth needs root to authenticate everybody. i think the others
	# do too so just do them all now. keep an eye on these things..
	chown root.squid ${D}/usr/lib/squid/*_auth*
	chmod 4750 ${D}/usr/lib/squid/*_auth*

	dodoc README QUICKSTART CONTRIBUTORS COPYRIGHT
	dodoc COPYING CREDITS ChangeLog TODO
	newdoc auth_modules/SMB/README SMB.auth.readme
	newdoc auth_modules/LDAP/README LDAP.auth.readme
	doman auth_modules/LDAP/*.8 doc/tree.3
	docinto txt ; dodoc doc/*.txt

	insinto /etc/pam.d ; newins ${FILESDIR}/squid.pam squid
	exeinto /etc/init.d ; newexe ${FILESDIR}/squid.rc6 squid
	insinto /etc/conf.d ; newins ${FILESDIR}/squid.confd squid
}
