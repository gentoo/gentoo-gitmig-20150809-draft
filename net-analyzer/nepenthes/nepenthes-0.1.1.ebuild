# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nepenthes/nepenthes-0.1.1.ebuild,v 1.1 2005/09/09 20:27:25 kaiowas Exp $

inherit eutils

DESCRIPTION="Nepenthes is a low interaction honeypot that captures worms by emulating known vulnerabilities"
HOMEPAGE="http://nepenthes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
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

src_unpack() {
	unpack ${P}.tar.bz2

	# patched as per sf tracker
	epatch ${FILESDIR}/magic.patch || die

	sed -i 's|var/log/nepenthes.log|/var/log/nepenthes/nepenthes.log|' "${S}/nepenthes-core/src/Nepenthes.cpp"
	sed -i 's|var/log/hexdumps/|/var/lib/nepenthes/hexdumps/|' "${S}/nepenthes-core/src/Utilities.cpp"
}

src_compile() {
	econf --sysconfdir=/etc/nepenthes --localstatedir=/var/lib/nepenthes || die
	emake || die "make failed"
}

src_install() {
	dodoc doc/README doc/README.VFS AUTHORS
	dosbin nepenthes-core/src/nepenthes || die "dosbin failed"

	make DESTDIR="${D}" install || die "make install failed"

	for i in ${D}/etc/nepenthes/*; do
		sed -i 's|"var/binaries|"/var/lib/nepenthes/binaries|;s|"var/log|"/var/log/nepenthes|;s|"lib/nepenthes|"/usr/lib/nepenthes|;s|"etc|"/etc/nepenthes|' $i
	done

	rm ${D}/usr/bin/nepenthes
	rm ${D}/usr/share/doc/README
	rm ${D}/usr/share/doc/README.VFS
	rm ${D}/usr/share/doc/logo-shaded.svg

	newinitd ${FILESDIR}/${PN}.initd ${PN} || die
	newconfd ${FILESDIR}/${PN}.confd ${PN} || die

	diropts -m 755 -o nepenthes -g nepenthes
	keepdir /var/log/nepenthes
	keepdir /var/lib/nepenthes
	keepdir /var/lib/nepenthes/binaries
	keepdir /var/lib/nepenthes/hexdumps

}

