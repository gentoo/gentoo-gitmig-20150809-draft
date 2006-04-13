# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mDNSResponder/mDNSResponder-107.5.ebuild,v 1.3 2006/04/13 13:18:59 flameeyes Exp $

inherit eutils multilib base toolchain-funcs flag-o-matic

DESCRIPTION="The mDNSResponder project is a component of Bonjour, Apple's initiative for zero-configuration networking."
HOMEPAGE="http://developer.apple.com/networking/bonjour/index.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="APSL-2 BSD"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug java"

PATCHES="${FILESDIR}/${P}-Makefiles.patch"

pkg_setup() {
	if use elibc_FreeBSD; then
		os=freebsd
	else
		os=linux
	fi
}

mdnsmake() {
	local debug, jdk
	use java && jdk="JDK=$(java-config -O)"
	use debug && debug='DEBUG=1'
	einfo "Running emake " os="${os}" CC="$(tc-getCC)" LD="$(tc-getCC) -shared" \
		${jdk} ${debug} OPT_CFLAGS="${CFLAGS}" LIBFLAGS="${LDFLAGS}" \
		STRIP="true" LOCALBASE="/usr" "$@"
	emake os="${os}" CC="$(tc-getCC)" LD="$(tc-getCC) -shared" \
		${jdk} ${debug} OPT_CFLAGS="${CFLAGS}" LIBFLAGS="${LDFLAGS}" \
		STRIP="true" LOCALBASE="/usr" "$@"
}

src_compile() {
	cd ${S}/mDNSPosix
	mdnsmake || die "make mDNSPosix failed"

	if use java; then
		mdnsmake Java || die "make mDNSPosix java failed"
	fi

	cd ${S}/Clients
	mdnsmake || die "make Clients failed"
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

	make LOCALBASE="/usr" DESTDIR="${D}" os=${os} ${debug} install || die "install failed"

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

	# Fix multilib-strictness
	mv ${D}/lib ${D}/$(get_libdir)
	mv ${D}/usr/lib ${D}/usr/$(get_libdir)

	if use java; then
		java-pkg_dojar ${S}/mDNSPosix/build/prod/dns_sd.jar
		java-pkg_doso ${S}/mDNSPosix/build/prod/libjdns_sd.so
	fi

}

pkg_postinst() {
	echo
	einfo "To enable multicast dns lookups for applications"
	einfo "that are not multicast dns aware, edit the 'hosts:'"
	einfo "line in /etc/nsswitch.conf to include 'mdns', e.g.:"
	einfo "hosts: files mdns dns"
	echo
}
