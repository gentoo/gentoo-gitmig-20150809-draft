# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/xgpasm/xgpasm-1.0.ebuild,v 1.6 2005/01/01 17:57:17 eradicator Exp $

DESCRIPTION="GUI for GPASM"
HOMEPAGE="http://xizard.free.fr/logiciels/xgpasm/xgpasm.html"
SRC_URI="http://xizard.free.fr/download/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-1.2
	dev-embedded/gputils"

src_compile() {
	econf `use_enable nls` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS README
}
