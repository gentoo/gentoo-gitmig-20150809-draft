# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/totd/totd-1.3.ebuild,v 1.4 2004/07/15 03:39:06 agriffis Exp $

DESCRIPTION="Trick Or Treat Daemon, a DNS proxy for 6to4"
HOMEPAGE="http://www.vermicelli.pasta.cs.uit.no/ipv6/software.html"
SRC_URI="ftp://ftp.pasta.cs.uit.no/pub/Vermicelli/${P}.tar.gz"
LICENSE="BSD as-is"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dosbin totd
	doman totd.8
	dodoc totd.conf.sample README INSTALL

	exeinto /etc/init.d
	doexe ${FILESDIR}/totd
}

pkg_postinst() {
	einfo "/usr/share/doc/${P}/totd.conf.sample.gz contains"
	einfo "a sample config file for totd. Make sure you create"
	einfo "/etc/totd.conf with the necessary configurations"
}
