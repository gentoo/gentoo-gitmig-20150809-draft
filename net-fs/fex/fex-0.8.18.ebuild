# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/fex/fex-0.8.18.ebuild,v 1.1 2006/05/20 14:36:32 xmerlin Exp $

DESCRIPTION="Fex is a replicating filesystem for disconnected computers similar to intermezzo"
HOMEPAGE="http://www.zahlfee.de/fex/fex.html"
SRC_URI="http://www.zahlfee.de/fex/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/confuse
	dev-libs/log4cpp
	net-libs/librsync
	dev-libs/popt
	"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "install problem"

	newinitd ${FILESDIR}/${PN}.rc ${PN}d || die
	newconfd ${FILESDIR}/${PN}.conf.d ${PN}d || die
}

pkg_postinst() {
	einfo "To enable fex on boot you will have to add it to the"
	einfo "default profile, issue the following command as root to do so."
	einfo "rc-update add fexd default"
}
