# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/texmfind/texmfind-0.1.ebuild,v 1.6 2008/07/06 03:14:58 wormo Exp $

DESCRIPTION="Finds which ebuild provide a texmf file matching a grep regexp."
HOMEPAGE="http://home.gna.org/texmfind"
SRC_URI="http://download.gna.org/texmfind/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

src_install() {
	dobin texmfind 						   || die "dobin failed"
	doman texmfind.1 					   || die "doman failed"
	insinto /usr/share/texmf-site/texmfind || die "insinto failed"
	doins texmf_files 					   || die "doins failed"
}
