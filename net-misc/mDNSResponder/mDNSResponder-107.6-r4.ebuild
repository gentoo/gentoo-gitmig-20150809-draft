# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mDNSResponder/mDNSResponder-107.6-r4.ebuild,v 1.1 2007/04/28 15:12:04 carlo Exp $

inherit eutils base toolchain-funcs flag-o-matic java-pkg-opt-2

DESCRIPTION="The mDNSResponder project is a component of Bonjour, Apple's initiative for zero-configuration networking."
HOMEPAGE="http://developer.apple.com/networking/bonjour/index.html"
SRC_URI="http://www.opensource.apple.com/darwinsource/tarballs/other/${P}.tar.gz"
LICENSE="APSL-2 BSD"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc ipv6"

DEPEND="!sys-auth/nss-mdns
		java? ( >=virtual/jdk-1.5 )"
RDEPEND="!sys-auth/nss-mdns
		java? ( >=virtual/jre-1.5 )"

PATCHES="${FILESDIR}/mDNSResponder-107.6-Makefiles.diff ${FILESDIR}/mDNSResponder-107.6-java.patch"
pkg_setup() {
	if use elibc_FreeBSD; then
		os=freebsd
	else
		os=linux
	fi
}

mdnsmake() {
	local debug jdk __ipv6
	use java && jdk="JDK=$(java-config -O)"
	use debug && debug='DEBUG=1'
	use ipv6 && __ipv6='HAVE_IPV6=1' || __ipv6='HAVE_IPV6=0'
	einfo "Running emake " os="${os}" CC="$(tc-getCC)" LD="$(tc-getCC) -shared" \
		${jdk} ${debug} OPT_CFLAGS="${CFLAGS}" LIBFLAGS="${LDFLAGS}" \
		 LOCALBASE="/usr" JAVACFLAGS="$(java-pkg_javac-args)" "$@"
	emake -j1 os="${os}" CC="$(tc-getCC)" LD="$(tc-getCC) -shared" \
		${jdk} ${debug} OPT_CFLAGS="${CFLAGS}" LIBFLAGS="${LDFLAGS}" \
		LOCALBASE="/usr" JAVACFLAGS="$(java-pkg_javac-args)" ${__ipv6} "$@"
}

src_compile() {
	cd ${S}/mDNSPosix
	mdnsmake || die "make failed"

	if use java; then
		mdnsmake Java || die "make mDNSPosix java failed"
		if use doc ; then
			mdnsmake JavaDoc || die "make mDNSPosix java doc failed"
		fi
	fi
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

	dosbin ${S}/mDNSPosix/build/${objdir}/dnsextd
	dosbin ${S}/mDNSPosix/build/${objdir}/mDNSResponderPosix
	dosbin ${S}/mDNSPosix/build/${objdir}/mDNSNetMonitor
	dosbin ${S}/mDNSPosix/build/${objdir}/mdnsd

	dobin ${S}/Clients/build/dns-sd
	dobin ${S}/mDNSPosix/build/${objdir}/mDNSProxyResponderPosix
	dobin ${S}/mDNSPosix/build/${objdir}/mDNSIdentify
	dobin ${S}/mDNSPosix/build/${objdir}/mDNSClientPosix

	dolib ${S}/mDNSPosix/build/${objdir}/libdns_sd.so
	dolib ${S}/mDNSPosix/build/${objdir}/libnss_mdns-0.2.so
	dosym libdns_sd.so /usr/$(get_libdir)/libdns_sd.so.1
	dosym libnss_mdns-0.2.so /usr/$(get_libdir)/libnss_mdns.so.2

	newinitd ${FILESDIR}/mdnsd.init.d mdnsd
	newinitd ${FILESDIR}/mDNSResponderPosix.init.d mDNSResponderPosix
	newconfd ${FILESDIR}/mDNSResponderPosix.conf.d mDNSResponderPosix
	newinitd ${FILESDIR}/dnsextd.init.d dnsextd
	newconfd ${FILESDIR}/dnsextd.conf.d dnsextd

	insinto /etc
	doins ${FILESDIR}/mDNSResponderPosix.conf

	insinto /usr/include
	doins ${S}/mDNSShared/dns_sd.h

	dodoc ${S}/README.txt

	if use java; then
		java-pkg_dojar ${S}/mDNSPosix/build/${objdir}/dns_sd.jar
		java-pkg_doso ${S}/mDNSPosix/build/${objdir}/libjdns_sd.so
		use doc && java-pkg_dojavadoc ${S}/mDNSPosix/build/${objdir}
	fi

}

pkg_postinst() {
	echo
	elog "To enable multicast dns lookups for applications"
	elog "that are not multicast dns aware, edit the 'hosts:'"
	elog "line in /etc/nsswitch.conf to include 'mdns', e.g.:"
	elog "hosts: files mdns dns"
	echo
}
