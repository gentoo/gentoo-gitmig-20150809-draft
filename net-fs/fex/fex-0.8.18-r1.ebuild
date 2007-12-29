# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/fex/fex-0.8.18-r1.ebuild,v 1.1 2007/12/29 03:56:06 dirtyepic Exp $

inherit eutils autotools

DESCRIPTION="Fex is a replicating filesystem for disconnected computers similar to intermezzo"
HOMEPAGE="http://www.zahlfee.de/fex/fex.html"
SRC_URI="http://www.zahlfee.de/fex/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="dev-libs/confuse
	dev-libs/log4cpp
	net-libs/librsync
	dev-libs/popt
	"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-lpthread.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch

	eautoreconf
}

src_compile() {
	econf \
		$(use_enable debug) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}"/${PN}.rc ${PN}d || die
	newconfd "${FILESDIR}"/${PN}.conf.d ${PN}d || die
}

pkg_postinst() {
	elog "To enable fex on boot you will have to add it to the"
	elog "default profile, issue the following command as root to do so."
	elog "rc-update add fexd default"
}
