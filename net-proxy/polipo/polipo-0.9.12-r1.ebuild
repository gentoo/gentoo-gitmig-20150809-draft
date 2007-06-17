# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/polipo/polipo-0.9.12-r1.ebuild,v 1.4 2007/06/17 07:00:10 mrness Exp $

inherit eutils

DESCRIPTION="A caching web proxy"
HOMEPAGE="http://www.pps.jussieu.fr/~jch/software/polipo/"
SRC_URI="http://www.pps.jussieu.fr/~jch/software/files/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sys-apps/texinfo"

pkg_setup() {
	enewgroup polipo
	enewuser polipo -1 -1 /var/cache/polipo polipo
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-printf-ptr.patch"
}

src_compile() {
	emake "PREFIX=/usr" "CDEBUGFLAGS=${CFLAGS}" all || die "build failed"
}

src_install() {
	einstall "PREFIX=/usr" "TARGET=${D}" || die "install failed"
	mv polipo.man polipo.1
	doman "${S}/polipo.1"
	doinfo "${S}/polipo.info"

	newinitd "${FILESDIR}/polipo-0.9.12.initd" polipo
	insinto /etc/polipo ; doins "${FILESDIR}/config"
	exeinto /etc/cron.daily ; newexe "${FILESDIR}/polipo.crond" polipo.sh

	diropts -m0750 -o polipo -g polipo
	keepdir /var/cache/polipo
}

pkg_preinst() {
	pkg_setup
}

pkg_postinst() {
	einfo "Do not forget to read the manual."
	einfo "Change the config file in /etc/polipo to suit your needs."
}
