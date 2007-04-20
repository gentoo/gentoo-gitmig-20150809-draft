# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-9999.ebuild,v 1.1 2007/04/20 04:29:34 vapier Exp $

EGIT_REPO_URI="git://neil.brown.name/portmap"
inherit eutils flag-o-matic toolchain-funcs git

DESCRIPTION="Netkit - portmapper"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE="selinux tcpd"

RDEPEND="selinux? ( sec-policy/selinux-portmap )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r7 )"
DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup rpc 111
	enewuser rpc 111 -1 /dev/null rpc
}

src_compile() {
	tc-export CC
	export NO_TCP_WRAPPER=$(use tcpd || echo no)
	emake || die
}

src_install() {
	into /
	dosbin portmap || die "portmap"
	into /usr
	dosbin pmap_dump pmap_set || die "pmap"

	doman *.8
	dodoc BLURB CHANGES README

	newinitd "${FILESDIR}"/portmap.rc6 portmap
	newconfd "${FILESDIR}"/portmap.confd portmap
}
