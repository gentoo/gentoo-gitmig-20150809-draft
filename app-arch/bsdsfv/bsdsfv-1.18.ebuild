# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdsfv/bsdsfv-1.18.ebuild,v 1.10 2005/04/10 20:51:38 vapier Exp $

DESCRIPTION="all-in-one SFV checksum utility"
HOMEPAGE="http://bsdsfv.sourceforge.net/"
SRC_URI="mirror://sourceforge/bsdsfv/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-amd64 arm ppc ppc-macos sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

src_install() {
	dobin bsdsfv || die
	dodoc README MANUAL
}
