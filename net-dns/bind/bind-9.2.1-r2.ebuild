# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dns/bind/bind-9.2.1-r2.ebuild,v 1.7 2002/08/07 21:45:19 nitro Exp $

S=${WORKDIR}/${P}
DESCRIPTION="BIND - Name Server"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.isc.org/products/BIND"

KEYWORDS="x86 ppc"
LICENSE="as-is"
SLOT="0"

DEPEND="sys-apps/groff
	ssl? ( >=dev-libs/openssl-0.9.6 )"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf

	use ssl && myconf="${myconf} --with-openssl"
	use ipv6 && myconf="${myconf} --enable-ipv6"

	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		--sysconfdir=/etc/bind \
		--localstatedir=/var \
		--enable-threads \
		--with-libtool \
		${myconf} || die "failed to configure bind"

	make || die "failed to compile bind"
}

src_install() {
	make DESTDIR=${D} install || die "failed to install bind"
	
	for x in `grep -l -d recurse -e '/etc/named.conf' -e '/etc/rndc.conf' -e '/etc/rndc.key' ${D}/usr/man`; do
		cp ${x} ${x}.orig
		sed -e 's:/etc/named.conf:/etc/bind/named.conf:g' \
			-e 's:/etc/rndc.conf:/etc/bind/rndc.conf:g' \
			-e 's:/etc/rndc.key:/etc/bind/rndc.key:g' ${x}.orig > ${x}
		rm ${x}.orig
	done
	
	find ${D}/usr/man ! -name "*[1-8]gz" -type f -exec gzip -f "{}" \;
	insinto /usr/man/man5 ; doins ${FILESDIR}/named.conf.5.gz
	
	dodoc CHANGES COPYRIGHT FAQ README
	docinto misc ; dodoc doc/misc/*
	docinto html ; dodoc doc/arm/*
	docinto contrib ; dodoc contrib/named-bootconf/named-bootconf.sh \
		contrib/nanny/nanny.pl

	# some handy-dandy dynamic dns examples
	cd ${D}/usr/share/doc/${PF}
	tar pjxf ${FILESDIR}/dyndns-samples.tbz2

	dodir /etc/bind /var/bind /var/bind/pri /var/bind/sec

	insinto /etc/bind ; doins ${FILESDIR}/named.conf
	# ftp://ftp.rs.internic.net/domain/named.ca:
	insinto /var/bind ; doins ${FILESDIR}/named.ca
	insinto /var/bind/pri ; doins ${FILESDIR}/127.0.0

	exeinto /etc/init.d ; newexe ${FILESDIR}/named.rc6 named
	insinto /etc/conf.d ; newins ${FILESDIR}/named.confd named
	
	dosym /var/bind/named.ca /var/bind/root.cache 
	dosym /var/bind/pri /etc/bind/pri
	dosym /var/bind/sec	/etc/bind/sec
}

pkg_postinst() {
	if [ ! -f '/etc/bind/rndc.key' ]; then
		/usr/sbin/rndc-confgen -a -u named
	fi

	install -d -o named -g named ${ROOT}/var/run/named \
		${ROOT}/var/bind/pri ${ROOT}/var/bind/sec
	chown -R named:named ${ROOT}/var/bind

	echo
	einfo "Bind-9.2.1-r2 version and higher now include chroot support."
	einfo "If you would like to run bind in chroot, run:"
	einfo "\`ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\`"
	echo
}

pkg_config() {
	# chroot concept contributed by j2ee (kevin@aptbasilicata.it)

	mkdir -p /chroot/{dns/{dev,etc,var/run/named}}
	chown -R named:named /chroot/dns/var/run/named
	cp -R /etc/bind /chroot/dns/etc/
	cp /etc/localtime /chroot/dns/etc/localtime
	chown named:named /chroot/dns/etc/bind/rndc.key
	chgrp named	/chroot/dns/etc/bind/named.conf
	cp -R /var/bind /chroot/dns/var/
	chown -R named:named /chroot/dns/var/bind/{pri,sec}
	mknod /chroot/dns/dev/zero c 1 5
	mknod /chroot/dns/dev/random c 1 8
	chmod 666 /chroot/dns/dev/{random,zero}
	cp -a /dev/log /chroot/dns/dev/log

	chmod 700 /{chroot,chroot/dns}
	chown named:named /chroot/dns

	cp /etc/conf.d/named /etc/conf.d/named.orig
	sed -e 's:^#CHROOT="/chroot/dns"$:CHROOT="/chroot/dns":' \
		/etc/conf.d/named.orig > /etc/conf.d/named
	rm -f /etc/conf.d/named.orig

	einfo "Check your config files in /chroot/dns"
	einfo "Add the following to your root .bashrc or .bash_profile: "
	einfo "   alias rndc='rndc -k /chroot/dns/etc/bind/rndc.key'"
	einfo "Then do the following: "
	einfo "   source /root/.bashrc or .bash_profile"
	echo
}
