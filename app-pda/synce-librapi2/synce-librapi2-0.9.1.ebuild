# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-librapi2/synce-librapi2-0.9.1.ebuild,v 1.2 2006/03/16 18:09:36 sekretarz Exp $

DESCRIPTION="Synchronize Windows CE devices with Linux. RAPI DLL emulation."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=dev-libs/check-0.8.2
	>=app-pda/synce-libsynce-0.9.1"

src_install() {
	make DESTDIR=${D} install || die
	dodoc README README.contributing README.design
}
