# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.6.11.20050310-r1.ebuild,v 1.1 2005/03/29 03:10:25 vapier Exp $

inherit eutils toolchain-funcs

MY_PV=${PV%.*}
SNAP=${PV##*.}
SNAP=${SNAP:2}
DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://developer.osdl.org/dev/iproute2/"
SRC_URI="http://developer.osdl.org/dev/iproute2/download/${PN}-${MY_PV}-${SNAP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="atm berkdb minimal"

RDEPEND="!minimal? ( berkdb? ( sys-libs/db ) )
	atm? ( net-dialup/linux-atm )"
DEPEND="${RDEPEND}
	>=virtual/os-headers-2.4.21"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-dsmark-qdisc.patch #86729
	sed -i -e "s:-O2:${CFLAGS}:" Makefile || die "sed Makefile failed"
	#68948 - esfq/wrr patches
	epatch \
		"${FILESDIR}"/2.6.9.20041106-esfq.patch \
		"${FILESDIR}"/2.6.9.20041019-wrr.patch
	# don't build arpd if USE=-berkdb #81660
	use berkdb || sed -i '/^TARGETS=/s: arpd : :' misc/Makefile
	# Multilib fixes
	sed -i 's:/usr/local:/usr:' tc/m_ipt.c
	sed -i "s:/usr/lib/tc:/usr/$(get_libdir)/tc:g" \
		tc/Makefile tc/tc.c tc/q_netem.c || die
}

src_compile() {
	echo -n 'TC_CONFIG_ATM:=' > Config
	use atm \
		&& echo 'y' >> Config \
		|| echo 'n' >> Config

	local SUBDIRS="lib ip tc misc"
	use minimal && SUBDIRS="lib tc"
	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		SUBDIRS="${SUBDIRS}" \
		|| die "make"
}

src_install() {
	if use minimal; then
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
		# bug 47482, arpd doesn't need to be in /sbin
		dodir /usr/sbin
		mv "${D}"/sbin/arpd "${D}"/usr/sbin/
	fi
}
