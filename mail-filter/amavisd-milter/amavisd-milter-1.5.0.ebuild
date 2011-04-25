# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/amavisd-milter/amavisd-milter-1.5.0.ebuild,v 1.1 2011/04/25 09:52:07 eras Exp $

EAPI=4

DESCRIPTION="sendmail milter for amavisd-new"
HOMEPAGE="http://amavisd-milter.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="mail-mta/sendmail
		mail-filter/amavisd-new"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS CHANGES INSTALL README TODO

	newinitd "${FILESDIR}/amavisd-milter.initd" amavisd-milter
	newconfd "${FILESDIR}/amavisd-milter.confd" amavisd-milter
}
