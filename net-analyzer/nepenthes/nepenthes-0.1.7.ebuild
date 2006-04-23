# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nepenthes/nepenthes-0.1.7.ebuild,v 1.1 2006/04/23 19:29:11 kaiowas Exp $

inherit eutils

DESCRIPTION="Nepenthes is a low interaction honeypot that captures worms by emulating known vulnerabilities"
HOMEPAGE="http://nepenthes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="selinux"

DEPEND="net-misc/curl
	sys-apps/file
	dev-libs/libpcre
	net-libs/adns"

RDEPEND=""
#RDEPEND=" selinux? ( sec-policy/selinux-nepenthes )"

pkg_setup() {
	enewgroup nepenthes
	enewuser nepenthes -1 -1 /dev/null nepenthes
}

src_compile() {
	local myconf="--sysconfdir=/etc --localstatedir=/var/lib/nepenthes --enable-capabilities"
	econf ${myconf} || die
	sed -i 's|var/cache|/var/lib/cache|' ${S}/modules/shellcode-signatures/shellcode-signatures.cpp
	emake || die "make failed"
}

src_install() {

	einstall || die "make install failed"

	for i in ${D}/etc/nepenthes/*; do
		sed -i \
			-e 's|"var/binaries|"/var/lib/nepenthes/binaries|' \
			-e 's|"var/hexdumps|"/var/lib/nepenthes/hexdumps|' \
			-e 's|"var/cache/nepenthes|"/var/lib/nepenthes/cache|' \
			-e 's|"var/log|"/var/log/nepenthes|' \
			-e 's|"lib/nepenthes|"/usr/lib/nepenthes|' \
			-e 's|"etc|"/etc|' $i
	done

	dodoc doc/README doc/README.VFS AUTHORS
	dosbin nepenthes-core/src/nepenthes || die "dosbin failed"
	rm ${D}/usr/bin/nepenthes
	rm ${D}/usr/share/doc/README
	rm ${D}/usr/share/doc/README.VFS
	rm ${D}/usr/share/doc/logo-shaded.svg

	newinitd ${FILESDIR}/${PN}.initd ${PN}
	newconfd ${FILESDIR}/${PN}.confd ${PN}

	diropts -m 755 -o nepenthes -g nepenthes
	keepdir /var/log/nepenthes
	keepdir /var/lib/nepenthes
	keepdir /var/lib/nepenthes/binaries
	keepdir /var/lib/nepenthes/hexdumps
	keepdir /var/lib/nepenthes/cache
	keepdir /var/lib/nepenthes/cache/geolocation

}

