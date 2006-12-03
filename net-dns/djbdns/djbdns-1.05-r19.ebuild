# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/djbdns/djbdns-1.05-r19.ebuild,v 1.3 2006/12/03 19:58:25 corsair Exp $

IUSE="aliaschain cnamefix doc fwdonly fwdzone ipv6 \
	multipleip roundrobin semanticfix static selinux \
	multidata datadir"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Excellent high-performance DNS services"
HOMEPAGE="http://cr.yp.to/djbdns.html"
IPV6_PATCH="test23"

JBP_PATCHES="http://homepages.tesco.net/~J.deBoynePollard/Softwares/djbdns"
SRC_URI="http://cr.yp.to/djbdns/${P}.tar.gz
	fwdzone? (
		http://www.skarnet.org/software/djbdns-fwdzone/djbdns-1.04-fwdzone.patch
	)
	fwdonly? ( ${JBP_PATCHES}/dnscache-strict-forwardonly.patch )
	roundrobin? ( http://www.legend.co.uk/djb/dns/round-robin.patch )
	multipleip? (
		http://danp.net/djbdns/dnscache-multiple-ip.patch
		http://www.ohse.de/uwe/patches/djbdns-1.05-multiip.diff
	)
	aliaschain? ( ${JBP_PATCHES}/tinydns-alias-chain-truncation.patch )
	semanticfix? ( ${JBP_PATCHES}/tinydns-data-semantic-error.patch )
	cnamefix? ( ${JBP_PATCHES}/dnscache-cname-handling.patch )
	ipv6? ( http://www.fefe.de/dns/${P}-${IPV6_PATCH}.diff.bz2 )
	datadir? (
		http://dustman.net/andy/djbware/tinydns-datadir/0.0.0/djbdns-1.0.5-datadir.patch
	)
	multidata? (
		http://js.hu/package/djbdns-conf/djbdns-1.05-multi_tinydns_data.patch
	)"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 hppa ~mips ppc ppc64 sparc x86"

RDEPEND=">=sys-process/daemontools-0.70
	doc? ( app-doc/djbdns-man )
	sys-apps/ucspi-tcp
	selinux? ( sec-policy/selinux-djbdns )"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"

	use ipv6 && use cnamefix && \
		die "ipv6 cannot currently be used with the cnamefix patch"

	use ipv6 && use multipleip && \
		die "ipv6 cannot currently be used with the multipleip patch"

	if use ipv6 && ( use fwdzone || use roundrobin ); then
		eerror "ipv6 cannot currently be used with the fwdzone or "
		eerror "roundrobin patch."
		echo
		eerror "If you would like to see ipv6 support along with one of "
		eerror "those other patches, please submit a working patch that "
		eerror "combines ipv6 with either fwdzone or roundrobin but not "
		eerror "both at the same time, since the latter 2 patches are "
		eerror "mutually exclusive according to bug #31238."
		die
	fi

	use fwdzone && use roundrobin && \
		die "fwdzone and roundrobin do not work together according to bug #31238"

	use datadir && use multidata && \
		die "The datadir and multidata patches are not compatible with each other"

	use cnamefix && \
		sed 's:\r::g' < "${DISTDIR}/dnscache-cname-handling.patch" \
		> "${WORKDIR}/dnscache-cname-handling.patch" && \
		epatch "${WORKDIR}/dnscache-cname-handling.patch"
	use aliaschain && \
		epatch "${DISTDIR}/tinydns-alias-chain-truncation.patch"
	use semanticfix && \
		epatch "${DISTDIR}/tinydns-data-semantic-error.patch"
	use fwdzone && \
		epatch "${DISTDIR}/djbdns-1.04-fwdzone.patch"
	use roundrobin && \
		epatch "${DISTDIR}/round-robin.patch"
	use multipleip && \
		epatch "${DISTDIR}/dnscache-multiple-ip.patch" && \
		epatch "${DISTDIR}/djbdns-1.05-multiip.diff"
	use datadir && \
		epatch "${DISTDIR}/djbdns-1.0.5-datadir.patch"
	use multidata && \
		epatch "${DISTDIR}/djbdns-1.05-multi_tinydns_data.patch"
	use fwdonly && \
		epatch "${DISTDIR}/dnscache-strict-forwardonly.patch"

	epatch \
		"${FILESDIR}/headtail.patch" \
		"${FILESDIR}/dnsroots.patch" \
		"${FILESDIR}/dnstracesort.patch"

	if use ipv6; then
		einfo "At present dnstrace does NOT support IPv6. It will"\
		      "be compiled without IPv6 support."
		cp -pR "${S}" "${S}-noipv6"
		# Careful -- >=test21 of the IPv6 patch includes the errno patch
		epatch "${DISTDIR}/${P}-${IPV6_PATCH}.diff.bz2"
		cd "${S}-noipv6"
	fi

	epatch "${FILESDIR}/${PV}-errno.patch"

	if [[ -n "${DJBDNS_PATCH_DIR}" && -d "${DJBDNS_PATCH_DIR}" ]]
	then
		echo
		ewarn "You enabled custom patches from ${DJBDNS_PATCH_DIR}."
		ewarn "Be warned that you won't get any support when using "
		ewarn "this feature. You're on your own from now!"
		ebeep
		epatch "${DJBDNS_PATCH_DIR}/"*
		echo
	fi
}

src_compile() {
	use static && append-ldflags -static
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo "/usr" > conf-home
	emake -j1 || die "emake failed"

	# If djbdns is compiled with IPv6 support, it breaks dnstrace.
	# Therefore we must compile dnstrace separately without IPv6
	# support.
	if use ipv6; then
		einfo "Compiling dnstrace without ipv6 support"
		cd ${S}-noipv6
		echo "$(tc-getCC) ${CFLAGS}" > conf-cc
		echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
		echo "/usr" > conf-home
		emake -j1 dnstrace || die "emake failed"
	fi
}

src_install() {
	insinto /etc
	doins dnsroots.global

	into /usr
	dobin *-conf dnscache tinydns walldns rbldns pickdns axfrdns \
		*-get *-data *-edit dnsip dnsipq dnsname dnstxt dnsmx \
		dnsfilter random-ip dnsqr dnsq dnstrace dnstracesort

	use ipv6 && dobin dnsip6 dnsip6q "${S}-noipv6/dnstrace"

	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION

	dobin "${FILESDIR}/dnscache-setup"
	use fwdzone && cd "${D}${DESTTREE}/bin" && \
		epatch "${FILESDIR}/fwdzone-fix.patch"
	dobin "${FILESDIR}/tinydns-setup"
	newbin "${FILESDIR}/djbdns-setup-${PR}" djbdns-setup
}

pkg_setup() {
	# The nofiles group is provided by baselayout
	enewuser dnscache -1 -1 -1 nofiles
	enewuser dnslog -1 -1 -1 nofiles
	enewuser tinydns -1 -1 -1 nofiles
}

pkg_postinst() {
	einfo "Use dnscache-setup & tinydns-setup or djbdns-setup"\
	      "to configure djbdns."
}
