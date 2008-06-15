# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/signature/signature-0.14.ebuild,v 1.1 2008/06/15 12:38:27 dertobi123 Exp $

DESCRIPTION="signature produces dynamic signatures for livening up your e-mail and news postings."
SRC_URI="http://www.caliban.org/files/signature/${P}.tar.gz"
HOMEPAGE="http://www.caliban.org/linux_signature.html"
LICENSE="GPL-2"
DEPEND="games-misc/fortune-mod"
IUSE=""
SLOT=0
KEYWORDS="~x86 ~amd64"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
