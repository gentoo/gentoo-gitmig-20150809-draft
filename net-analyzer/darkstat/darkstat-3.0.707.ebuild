# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/darkstat/darkstat-3.0.707.ebuild,v 1.1 2007/11/01 13:29:39 jokey Exp $

DESCRIPTION="darkstat is a network traffic analyzer"
HOMEPAGE="http://dmr.ath.cx/net/darkstat/"
SRC_URI="http://dmr.ath.cx/net/darkstat/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE="nls"
LICENSE="GPL-2"
SLOT="0"

DEPEND="net-libs/libpcap
	nls? ( virtual/libintl )"
RDEPEND=${DEPEND}

src_compile() {
	econf $(use_with nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS README THANKS

	newinitd "${FILESDIR}"/darkstat-init2 darkstat
	newconfd "${FILESDIR}"/darkstat-confd2 darkstat
}

pkg_postinst() {
	elog "To start different darkstat instances which will listen on a different"
	elog "interfaces create in /etc/init.d directory the 'darkstat.if' symlink to"
	elog "darkstat script where 'if' is the name of the interface."
	elog "Also in /etc/conf.d directory copy darkstat to darkstat.if"
	elog "and edit it to change default values"
}
