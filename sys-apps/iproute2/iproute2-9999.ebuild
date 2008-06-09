# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-9999.ebuild,v 1.2 2008/06/09 00:57:06 vapier Exp $

EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git"
inherit eutils toolchain-funcs git

DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://linux-net.osdl.org/index.php/Iproute2"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="atm berkdb minimal"

RDEPEND="!minimal? ( berkdb? ( sys-libs/db ) )
	atm? ( net-dialup/linux-atm )"
DEPEND="${RDEPEND}
	>=virtual/os-headers-2.4.21"

src_unpack() {
	git_src_unpack
	cd "${S}"
	sed -i "s:-O2:${CFLAGS}:" Makefile || die "sed Makefile failed"

	# don't build arpd if USE=-berkdb #81660
	use berkdb || sed -i '/^TARGETS=/s: arpd : :' misc/Makefile
	# Multilib fixes
	sed -i 's:/usr/local:/usr:' tc/m_ipt.c include/iptables.h
	sed -i "s:/usr/lib:/usr/$(get_libdir):g" \
		netem/Makefile tc/{Makefile,tc.c,q_netem.c,m_ipt.c} include/iptables.h || die
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
		install \
		|| die "make install failed"
	if use berkdb ; then
		dodir /var/lib/arpd
		# bug 47482, arpd doesn't need to be in /sbin
		dodir /usr/sbin
		mv "${D}"/sbin/arpd "${D}"/usr/sbin/
	fi
}
