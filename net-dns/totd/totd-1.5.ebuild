# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/totd/totd-1.5.ebuild,v 1.3 2007/05/06 09:24:36 genone Exp $

DESCRIPTION="Trick Or Treat Daemon, a DNS proxy for 6to4"
HOMEPAGE="http://www.vermicelli.pasta.cs.uit.no/ipv6/software.html"
SRC_URI="ftp://ftp.pasta.cs.uit.no/pub/Vermicelli/${P}.tar.gz"
LICENSE="BSD as-is"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_compile() {
	econf --enable-ipv4 --enable-ipv6 --enable-stf \
		--enable-scoped-rewrite --disable-http-server || die "configure failed"
	emake || die "make failed"
}

src_install() {
	dosbin totd
	doman totd.8
	dodoc totd.conf.sample README INSTALL

	doinitd ${FILESDIR}/totd
}

pkg_postinst() {
	elog "/usr/share/doc/${P}/totd.conf.sample.gz contains"
	elog "a sample config file for totd. Make sure you create"
	elog "/etc/totd.conf with the necessary configurations"
}
