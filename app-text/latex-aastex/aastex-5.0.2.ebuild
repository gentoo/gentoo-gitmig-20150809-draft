# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/latex-aastex/aastex-5.0.2.ebuild,v 1.1 2003/06/09 07:26:52 satai Exp $

inherit latex-package

MY_P=${PN/latex-/}${PV//./}
S=${WORKDIR}/${MY_P}
DESCRIPTION="LaTeX package used to mark up manuscripts for American Astronomical Society journals. (AASTeX)"
HOMEPAGE="http://www.journals.uchicago.edu/AAS/AASTeX/"
SRC_URI="http://www.journals.uchicago.edu/AAS/AASTeX/${MY_P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"
