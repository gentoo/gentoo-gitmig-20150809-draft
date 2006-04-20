# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.6.15.20060110.ebuild,v 1.10 2006/04/20 00:49:05 vapier Exp $

inherit eutils toolchain-funcs

MY_PV=${PV%.*}
SNAP=${PV##*.}
SNAP=${SNAP:2}
DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://linux-net.osdl.org/index.php/Iproute2"
SRC_URI="http://developer.osdl.org/dev/iproute2/download/${PN}-${MY_PV}-${SNAP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="atm berkdb minimal"

RDEPEND="!minimal? ( berkdb? ( sys-libs/db ) )
	atm? ( net-dialup/linux-atm )"
DEPEND="${RDEPEND}
	>=virtual/os-headers-2.4.21"

S=${WORKDIR}/${PN}-${MY_PV}-${SNAP}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:-O2:${CFLAGS}:" Makefile || die "sed Makefile failed"

	#68948 - esfq/wrr patches
	epatch "${FILESDIR}"/${PN}-051007-esfq-2.6.13.patch
	epatch "${FILESDIR}"/${PN}-2.6.11.20050330-wrr.patch

	# don't build arpd if USE=-berkdb #81660
	use berkdb || sed -i '/^TARGETS=/s: arpd : :' misc/Makefile
	# Multilib fixes
	sed -i 's:/usr/local:/usr:' tc/m_ipt.c
	sed -i "s:/usr/lib:/usr/$(get_libdir):g" \
		netem/Makefile tc/{Makefile,tc.c,q_netem.c,m_ipt.c} || die
}

src_compile() {
	echo -n 'TC_CONFIG_ATM:=' > Config
	use atm \
		&& echo 'y' >> Config \
		|| echo 'n' >> Config

	local SUBDIRS="lib ip tc misc netem"
	use minimal && SUBDIRS="lib tc"
	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		SUBDIRS="${SUBDIRS}" \
		|| die "make"
}

src_install() {
	if use minimal ; then
		into /
		dosbin tc/tc || die "minimal"
		return 0
	fi

	make \
		DESTDIR="${D}" \
		SBINDIR=/sbin \
		DOCDIR=/usr/share/doc/${PF} \
		install \
		|| die "make install failed"
	if use berkdb ; then
		dodir /var/lib/arpd
		# bug 47482, arpd doesn't need to be in /sbin
		dodir /usr/sbin
		mv "${D}"/sbin/arpd "${D}"/usr/sbin/
	fi
}
