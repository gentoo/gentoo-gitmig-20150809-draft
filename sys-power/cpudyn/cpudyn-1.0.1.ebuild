# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpudyn/cpudyn-1.0.1.ebuild,v 1.6 2007/08/13 21:57:42 dertobi123 Exp $

inherit eutils

DESCRIPTION="A daemon to control laptop power consumption via cpufreq and disk standby"
HOMEPAGE="http://mnm.uib.es/~gallir/cpudyn/"
SRC_URI="http://mnm.uib.es/~gallir/${PN}/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"/debian
	epatch "${FILESDIR}"/${PN}-0.99.0-init_conf_updates.patch
}

src_compile() {
	emake cpudynd || die "Compilation failed."
}

src_install() {
	dosbin cpudynd || die "dosbin"

	doman cpudynd.8
	dodoc INSTALL README VERSION changelog
	dohtml *.html

	newinitd "${FILESDIR}"/cpudyn.init cpudyn
	newconfd debian/cpudyn.conf cpudyn
}

pkg_postinst() {
	einfo "Configuration file is /etc/conf.d/cpudyn."
}
