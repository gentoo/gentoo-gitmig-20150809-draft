# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.6.26-r2.ebuild,v 1.13 2009/11/22 17:42:45 vapier Exp $

inherit eutils toolchain-funcs

if [[ ${PV} == *.*.*.* ]] ; then
	MY_PV=${PV%.*}
else
	MY_PV=${PV}
fi
MY_P="${PN}-${MY_PV}"
DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://www.linuxfoundation.org/collaborate/workgroups/networking/iproute2"
SRC_URI="http://developer.osdl.org/dev/iproute2/download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="atm berkdb minimal"

RDEPEND="!net-misc/arpd
	!minimal? ( berkdb? ( sys-libs/db ) )
	atm? ( net-dialup/linux-atm )"
DEPEND="${RDEPEND}
	elibc_glibc? ( >=sys-libs/glibc-2.7 )
	>=virtual/os-headers-2.6.25"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:-O2:${CFLAGS} ${CPPFLAGS}:" Makefile || die "sed Makefile failed"

	# build against system headers
	rm -r include/linux include/netinet #include/ip{,6}tables{,_common}.h include/libiptc

	epatch "${FILESDIR}"/${P}-ldflags.patch #236861
	epatch "${FILESDIR}"/${P}-linux-2.6.27-API.patch

	epatch_user

	# don't build arpd if USE=-berkdb #81660
	use berkdb || sed -i '/^TARGETS=/s: arpd : :' misc/Makefile
	# Multilib fixes
	sed -i 's:/usr/local:/usr:' tc/m_ipt.c include/iptables.h
	sed -i "s:/usr/lib:/usr/$(get_libdir):g" \
		netem/Makefile tc/{Makefile,tc.c,q_netem.c,m_ipt.c} include/iptables.h || die
	sed -i "s:/lib/tc:$(get_libdir)/tc:g" tc/Makefile || die
	# Use correct iptables dir, #144265.
	sed -i "s:/usr/local/lib/iptables:/$(get_libdir)/iptables:g" \
		include/iptables.h
}

src_compile() {
	echo -n 'TC_CONFIG_ATM:=' > Config
	use atm \
		&& echo 'y' >> Config \
		|| echo 'n' >> Config

	use minimal && sed -i -e '/^SUBDIRS=/s:=.*:=lib tc:' Makefile
	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		|| die "make"
}

src_install() {
	if use minimal ; then
		into /
		dosbin tc/tc || die "minimal"
		return 0
	fi

	emake \
		DESTDIR="${D}" \
		SBINDIR=/sbin \
		DOCDIR=/usr/share/doc/${PF} \
		MANDIR=/usr/share/man \
		install \
		|| die "make install failed"
	if use berkdb ; then
		dodir /var/lib/arpd
		# bug 47482, arpd doesn't need to be in /sbin
		dodir /usr/sbin
		mv "${D}"/sbin/arpd "${D}"/usr/sbin/
	fi
}
