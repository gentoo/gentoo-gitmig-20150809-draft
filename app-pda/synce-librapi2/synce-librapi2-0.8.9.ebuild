# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-librapi2/synce-librapi2-0.8.9.ebuild,v 1.4 2004/09/02 18:09:41 dholm Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/check-0.8.2
	>=app-pda/synce-libsynce-0.8.9"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README README.contributing README.design
}
