# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-core/nessus-core-2.3.0.ebuild,v 1.5 2005/03/21 13:56:49 ka0ttic Exp $

inherit toolchain-funcs

DESCRIPTION="A remote security scanner for Linux (nessus-core)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ppc64"
IUSE="tcpd gtk gtk2 debug"

DEPEND="=net-analyzer/nessus-libraries-${PV}
	=net-analyzer/libnasl-${PV}
	tcpd? ( sys-apps/tcp-wrappers )
	gtk? ( virtual/x11
		!gtk2? ( =x11-libs/gtk+-1.2* )
		gtk2? ( =x11-libs/gtk+-2* )
	)
	prelude? ( dev-libs/libprelude )"

S="${WORKDIR}/${PN}"

src_compile() {
	export CC=$(tc-getCC)
	econf \
		$(use_enable tcpd tcpwrappers) \
		$(use_enable debug) \
		$(use_enable gtk) \
		|| die "configure failed"
	emake || die "emake failed"

}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# net-analyzer/nessus-libraries provides includes.h
	rm ${D}/usr/include/nessus/includes.h

	dodoc README* UPGRADE_README CHANGES
	dodoc doc/*.txt doc/ntp/*

	newinitd ${FILESDIR}/nessusd-r7 nessusd || die "newinitd failed"
	keepdir /var/lib/nessus/logs
	keepdir /var/lib/nessus/users
}
