# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/aastex/aastex-5.2.ebuild,v 1.7 2004/10/30 19:45:42 weeve Exp $

inherit latex-package

MY_P=${PN/latex-/}${PV//./}
S=${WORKDIR}/${MY_P}
DESCRIPTION="LaTeX package used to mark up manuscripts for American Astronomical Society journals. (AASTeX)"
HOMEPAGE="http://www.journals.uchicago.edu/AAS/AASTeX/"
SRC_URI="http://www.journals.uchicago.edu/AAS/AASTeX/${MY_P}.tar.gz"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc alpha ~mips hppa ~amd64"

