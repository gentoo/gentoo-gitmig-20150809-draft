# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mDNSResponder/mDNSResponder-107.1.ebuild,v 1.1 2005/08/27 16:46:45 greg_g Exp $

inherit eutils

DESCRIPTION="The mDNSResponder project is a component of Bonjour, Apple's initiative for zero-configuration networking."
HOMEPAGE="http://developer.apple.com/networking/bonjour/index.html"
SRC_URI="http://helios.et.put.poznan.pl/~jstachow/pub/${P}.tar.gz"
LICENSE="APSL-2 BSD"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-Makefiles.patch"
}

src_compile() {
	local debug
	if use debug; then
		debug="DEBUG=1"
	fi

	cd ${S}/mDNSPosix
	emake os=linux ${debug} || die "make mDNSPosix failed"

	cd ${S}/Clients
	emake os=linux ${debug} || die "make Clients failed"
}

src_install() {
	cd "${S}/mDNSPosix"

	dodir /usr/sbin
	dodir /usr/lib
	dodir /usr/include
	dodir /lib
	dodir /etc
	dodir /usr/share/man/man5
	dodir /usr/share/man/man8

	local debug
	local objdir="prod"
	if use debug; then
		debug="DEBUG=1"
		objdir=debug
	fi

	emake DESTDIR="${D}" os=linux ${debug} install || die "install failed"

	dosbin ${S}/mDNSPosix/build/${objdir}/dnsextd
	dosbin ${S}/mDNSPosix/build/${objdir}/mDNSResponderPosix
	dosbin ${S}/mDNSPosix/build/${objdir}/mDNSNetMonitor

	dobin ${S}/Clients/build/dns-sd
	dobin ${S}/mDNSPosix/build/${objdir}/mDNSProxyResponderPosix
	dobin ${S}/mDNSPosix/build/${objdir}/mDNSIdentify

	newinitd ${FILESDIR}/mdnsd.init.d mdnsd
	newinitd ${FILESDIR}/mDNSResponderPosix.init.d mDNSResponderPosix
	newconfd ${FILESDIR}/mDNSResponderPosix.conf.d mDNSResponderPosix
	newinitd ${FILESDIR}/dnsextd.init.d dnsextd
	newconfd ${FILESDIR}/dnsextd.conf.d dnsextd

	insinto /etc
	doins ${FILESDIR}/mDNSResponderPosix.conf

	dodoc ${S}/README.txt
}

pkg_postinst() {
	echo
	einfo "To enable multicast dns lookups for applications"
	einfo "that are not multicast dns aware, edit the 'hosts:'"
	einfo "line in /etc/nsswitch.conf to include 'mdns', e.g.:"
	einfo "hosts: files mdns dns"
	echo
}
