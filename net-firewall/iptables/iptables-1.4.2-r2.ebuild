# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/iptables/iptables-1.4.2-r2.ebuild,v 1.3 2009/02/05 22:02:43 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Linux kernel (2.4+) firewall, NAT and packet mangling tools"
HOMEPAGE="http://www.iptables.org/"
SRC_URI="http://iptables.org/projects/iptables/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

DEPEND="virtual/os-headers"
RDEPEND=""

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
	epatch "${FILESDIR}"/${P}-glibc.patch
	epatch "${FILESDIR}"/${P}-no-ldconfig.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch #244431
	epatch "${FILESDIR}"/${P}-owner-restore.patch #255113
	epatch "${FILESDIR}"/${P}-libxt_TOS-compilation.patch
	epatch "${FILESDIR}"/${P}-libxt_iprange.c-build.patch
	epatch "${FILESDIR}"/${P}-hashlimit.patch #254496

	local check base=${PORTAGE_CONFIGROOT}/etc/portage/patches
	for check in {${CATEGORY}/${PF},${CATEGORY}/${P},${CATEGORY}/${PN}}; do
		EPATCH_SOURCE=${base}/${CTARGET}/${check}
		[[ -r ${EPATCH_SOURCE} ]] || EPATCH_SOURCE=${base}/${CHOST}/${check}
		[[ -r ${EPATCH_SOURCE} ]] || EPATCH_SOURCE=${base}/${check}
		if [[ -d ${EPATCH_SOURCE} ]] ; then
			EPATCH_SUFFIX="patch"
			EPATCH_FORCE="yes" \
			EPATCH_MULTI_MSG="Applying user patches from ${EPATCH_SOURCE} ..." \
			epatch
			break
		fi
	done
}

src_compile() {
	econf \
		--sbindir=/sbin \
		--libexecdir=/$(get_libdir) \
		--without-kernel \
		--enable-devel \
		--enable-libipq \
		--enable-shared \
		--enable-static \
		|| die
	emake V=1 || die
}

src_install() {
	emake install DESTDIR="${D}" || die

	insinto /usr/include
	doins include/iptables.h include/ip6tables.h || die
	dolib.a libiptc/libiptc.a || die
	insinto /usr/include/libiptc
	doins include/libiptc/*.h || die

	keepdir /var/lib/iptables
	newinitd "${FILESDIR}"/${PN}-1.3.2.init iptables
	newconfd "${FILESDIR}"/${PN}-1.3.2.confd iptables
	keepdir /var/lib/ip6tables
	newinitd "${FILESDIR}"/iptables-1.3.2.init ip6tables
	newconfd "${FILESDIR}"/ip6tables-1.3.2.confd ip6tables
}
