# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-3.0-r2.ebuild,v 1.5 2002/08/14 12:08:07 murphy Exp $

#This is only needed for a release with pl1 at the end.
P="dhcp-3.0pl1"

S=${WORKDIR}/${P}
DESCRIPTION="ISC Dynamic Host Configuration Protocol"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${P}.tar.gz"
HOMEPAGE="http://www.isc.org/products/DHCP"
LICENSE="isc-dhcp"
KEYWORDS="x86 ppc sparc sparc64"

SLOT="0"
DEPEND="virtual/glibc sys-apps/groff"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/includes
	cat <<- END >> site.h
#define _PATH_DHCPD_CONF "/etc/dhcp/dhcpd.conf"
#define _PATH_DHCLIENT_DB "/var/lib/dhcp/dhclient.leases"
#define _PATH_DHCPD_DB "/var/lib/dhcp/dhcpd.leases"
	END
}

src_compile() {
	cat <<- END > site.conf
CC = gcc ${CFLAGS}
ETC = /etc/dhcp
VARDB = /var/lib/dhcp
ADMMANDIR = /usr/share/man/man8
FFMANDIR = /usr/share/man/man5
LIBMANDIR = /usr/share/man/man3
END
	./configure --with-nsupdate || die
	emake || die
}

src_install() {
	dodir /var/lib/dhcp
	touch ${D}/var/lib/dhcp/dhclient.leases

	cd ${S}/work.linux-2.2/client
	into / ; dosbin dhclient
	into /usr ; doman *.5 *.8

	cd ../dhcpctl ; dolib libdhcpctl.a ; doman *.3
	insinto /usr/include ; doins dhcpctl.h

	cd ../omapip ; dolib libomapi.a ; doman *.3
	cd ../relay ; dosbin dhcrelay ; doman *.8
	cd ../common ; doman *.5
	cd ../server ; dosbin dhcpd ; doman *.5 *.8

	cd ${S}/client
	# admins might wanna edit dhclient-script, so /etc is proper for it.
	dosed "s:/etc/dhclient-script:/etc/dhcp/dhclient-script:" dhclient.conf
	insinto /etc/dhcp ; newins dhclient.conf dhclient.conf.sample
	exeinto /etc/dhcp ; newexe scripts/linux dhclient-script.sample

	cd ${S}/server
	insinto /etc/dhcp ; newins dhcpd.conf dhcpd.conf.sample

	cd ${S}/includes/omapip
	insinto /usr/include/omapip ; doins alloc.h buffer.h omapip.h

	cd ${S}/includes/isc-dhcp
	insinto /usr/include/isc-dhcp
	doins boolean.h dst.h int.h lang.h list.h result.h types.h

	cd ${S}
	dodoc ANONCVS CHANGES COPYRIGHT README RELNOTES
	newdoc client/dhclient.conf dhclient.conf.sample
	newdoc client/scripts/linux dhclient-script.sample
	newdoc server/dhcpd.conf dhcpd.conf.sample
	docinto doc ; dodoc doc/*

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.dhcpd dhcp

	exeinto /etc/init.d
	newexe ${FILESDIR}/dhcp.rc7 dhcp
}
