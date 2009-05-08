# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/peercast/peercast-0.1218-r1.ebuild,v 1.3 2009/05/08 15:38:32 ssuominen Exp $

inherit eutils toolchain-funcs flag-o-matic base

DESCRIPTION="A client and server for Peercast P2P-radio network"
HOMEPAGE="http://www.peercast.org"
SRC_URI="http://www.peercast.org/src/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND=""

S=${WORKDIR}

PATCHES=( "${FILESDIR}/${P}-CVE-2008-2040.patch"
	"${FILESDIR}/${PN}-0.1216-makefile.patch"
	"${FILESDIR}/${PN}-0.1216-amd64.patch" )

src_compile() {
	append-ldflags -pthread

	cd "${S}"/ui/linux
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" LDFLAGS="${LDFLAGS}" \
		LD="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	cd "${S}"/ui/linux

	exeinto /usr/sbin
	newexe "${FILESDIR}/peercast.wrapper.sh" peercast

	exeinto /usr/libexec
	doexe peercast

	dodir /usr/share/peercast
	cd "${S}"/ui
	cp -R html "${D}"/usr/share/peercast/

	newinitd "${FILESDIR}/peercast.init.gpl" peercast
}

pkg_postinst() {
	elog "Start Peercast with '/etc/init.d/peercast start' and point your"
	elog "webbrowser to 'http://localhost:7144' to start using Peercast."
	elog
	elog "You can also run 'rc-update add peercast default' to make Peercast"
	elog "start at boot."
}
