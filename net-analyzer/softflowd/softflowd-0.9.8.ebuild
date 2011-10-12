# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/softflowd/softflowd-0.9.8.ebuild,v 1.1 2011/10/12 19:57:02 vadimk Exp $

EAPI=3

DESCRIPTION="A flow-based network monitor."
HOMEPAGE="http://www.mindrot.org/softflowd.html"
SRC_URI="http://softflowd.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README TODO

	insinto /usr/share/doc/${PF}/examples
	doins collector.pl

	newinitd "${FILESDIR}/softflowd.initd" "softflowd"
	newconfd "${FILESDIR}/softflowd.confd" "softflowd"
}
