# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-051007.ebuild,v 1.1 2005/10/29 21:49:21 eradicator Exp $

inherit eutils toolchain-funcs

DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://linux-net.osdl.org/index.php/Iproute2/"
SRC_URI="http://developer.osdl.org/dev/iproute2/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="atm berkdb minimal"

RDEPEND="!minimal? ( berkdb? ( sys-libs/db ) )
	atm? ( net-dialup/linux-atm )"
DEPEND="${RDEPEND}
	>=virtual/os-headers-2.4.21"

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
		netem/Makefile tc/tc.c tc/q_netem.c tc/m_ipt.c || die
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
