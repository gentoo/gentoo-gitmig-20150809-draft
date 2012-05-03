# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/xgpasm/xgpasm-1.0.ebuild,v 1.9 2012/05/03 02:35:37 jdhore Exp $

DESCRIPTION="GUI for GPASM"
HOMEPAGE="http://xizard.free.fr/logiciels/xgpasm/xgpasm.html"
SRC_URI="http://xizard.free.fr/download/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="nls"

RDEPEND="=x11-libs/gtk+-1.2*
	dev-embedded/gputils"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	econf `use_enable nls` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS README
}
