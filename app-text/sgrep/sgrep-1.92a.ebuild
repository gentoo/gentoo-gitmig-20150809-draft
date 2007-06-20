# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sgrep/sgrep-1.92a.ebuild,v 1.5 2007/06/20 12:07:37 angelos Exp $

DESCRIPTION="Structured grep: tool for searching and indexing text, SGML,XML and HTML files and filtering text streams using structural criteria."
SRC_URI="ftp://ftp.cs.helsinki.fi/pub/Software/Local/Sgrep/${P}.tar.gz"
HOMEPAGE="http://www.cs.helsinki.fi/u/jjaakkol/sgrep.html"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE=""

DEPEND="virtual/libc"
SLOT="0"

src_compile() {
	econf --datadir=/etc || die "econf failed"
	emake || die "emake failed"

	sed -e "s:/usr/lib:/etc:g" sgrep.1 > sgrep.1.new
}

src_install() {
	dobin sgrep
	newman sgrep.1.new sgrep.1
	dodoc AUTHORS ChangeLog NEWS README sample.sgreprc
	insinto /etc
	newins sample.sgreprc sgreprc
}
