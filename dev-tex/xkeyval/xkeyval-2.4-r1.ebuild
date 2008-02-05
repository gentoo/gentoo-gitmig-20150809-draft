# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/xkeyval/xkeyval-2.4-r1.ebuild,v 1.3 2008/02/05 20:58:22 grobian Exp $

inherit latex-package

S=${WORKDIR}/${PN}

DESCRIPTION="xkeyval is an extension of the keyval package."
# Taken from: ftp://ftp.dante.de/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/xkeyval.html"
LICENSE="LPPL-1.2"
DEPEND="!>=app-text/tetex-3.0"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

src_install() {
	insinto /usr/share/texmf/tex/generic/${PN}
	doins ${S}/run/{keyval,pst-xkey,xkeyval,xkvtxhdr}.tex
	insinto /usr/share/texmf/tex/latex/${PN}
	doins ${S}/run/{pst-xkey,xkeyval,xkvview,xkvltxp}.sty

	dodoc README
	insinto /usr/share/doc/${PF}
	doins doc/*
}
