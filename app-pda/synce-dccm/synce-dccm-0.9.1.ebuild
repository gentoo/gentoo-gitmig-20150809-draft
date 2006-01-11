# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-dccm/synce-dccm-0.9.1.ebuild,v 1.1 2006/01/11 06:18:33 chriswhite Exp $

DESCRIPTION="Synchronize Windows CE devices with Linux. CE Connection Manager"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=app-pda/synce-libsynce-0.9.1"

src_install() {
	make DESTDIR=${D} install || die
}
