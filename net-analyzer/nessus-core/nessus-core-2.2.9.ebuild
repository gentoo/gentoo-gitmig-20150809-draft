# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-core/nessus-core-2.2.9.ebuild,v 1.1 2007/04/03 14:34:03 vanquirius Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A remote security scanner for Linux (nessus-core)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="X tcpd debug prelude"
DEPEND="=net-analyzer/nessus-libraries-${PV}
	=net-analyzer/libnasl-${PV}
	tcpd? ( sys-apps/tcp-wrappers )
	X? ( =x11-libs/gtk+-2* )
	prelude? ( dev-libs/libprelude )
	!net-analyzer/nessus-client"

S="${WORKDIR}/${PN}"

src_compile() {

	export CC="$(tc-getCC)"
	econf `use_enable tcpd tcpwrappers` \
		`use_enable debug` \
		`use_enable X gtk` \
		|| die "configure failed"
	emake -j1 || die "emake failed"

}

src_install() {
	make DESTDIR="${D}" \
		install || die "Install failed nessus-core"
	cd "${S}"
	dodoc README* UPGRADE_README CHANGES
	dodoc doc/*.txt doc/ntp/*
	insinto /etc/init.d
	insopts -m 755
	newins "${FILESDIR}"/nessusd-r7 nessusd
	keepdir /var/lib/nessus/logs
	keepdir /var/lib/nessus/users
	# newer version is provided by nessus-libraries
	# should be fixed upstream in version 2.2.6
	rm "${D}"/usr/include/nessus/includes.h
}
