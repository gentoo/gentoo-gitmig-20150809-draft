# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dns/bind/bind-9.2.1-r1.ebuild,v 1.5 2002/07/21 20:55:36 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="BIND - Name Server"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.isc.org/products/BIND"

KEYWORDS="x86 ppc"
LICENSE="as-is"
SLOT="0"

DEPEND="sys-apps/groff"

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
			-e 's:/etc/rndc.conf:/etc/bind/rndc.conf:g' ${x}.orig > ${x}
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
}
