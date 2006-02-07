# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/sispm_ctl/sispm_ctl-1.2.ebuild,v 1.1 2006/02/07 16:36:04 wschlich Exp $

DESCRIPTION="GEMBIRD SiS-PM control utility"
HOMEPAGE="http://mufasa.informatik.uni-mannheim.de/page.php?name=lsra/persons/mondrian/sisctl.html"
SRC_URI="http://mufasa.informatik.uni-mannheim.de/lsra/persons/mondrian/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=dev-libs/libusb-0.1.8"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog NEWS
}
