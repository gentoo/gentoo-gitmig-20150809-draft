# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-6.0.ebuild,v 1.6 2007/08/27 15:59:56 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="daemon for implementing remote procedure calls between computer programs"
HOMEPAGE="http://neil.brown.name/portmap/"
SRC_URI="http://neil.brown.name/portmap/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc ~x86"
IUSE="selinux tcpd"

DEPEND="selinux? ( sec-policy/selinux-portmap )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r7 )"

S=${WORKDIR}/${PN}_${PV}

pkg_setup() {
	enewgroup rpc 111
	enewuser rpc 111 -1 /dev/null rpc
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-tcpd.patch #178242
}

src_compile() {
	tc-export CC
	emake NO_TCP_WRAPPER="$(use tcpd || echo NO)" || die
}

src_install() {
	into /
	dosbin portmap || die "portmap"
	into /usr
	dosbin pmap_dump pmap_set || die "pmap"

	doman *.8
	dodoc BLURBv5 CHANGES README*

	newinitd "${FILESDIR}"/portmap.rc6 portmap
	newconfd "${FILESDIR}"/portmap.confd portmap
}
