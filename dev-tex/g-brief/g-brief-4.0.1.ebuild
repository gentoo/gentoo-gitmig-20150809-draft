# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/g-brief/g-brief-4.0.1.ebuild,v 1.1 2003/07/24 04:48:38 pylon Exp $

inherit latex-package

S=${WORKDIR}/g-brief
DESCRIPTION="LaTeX package for formatting formless letters in german or english language."
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="ftp://ibiblio.org/pub/packages/TeX/macros/latex/contrib/supported/g-brief/"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

# checksum from official ftp site changes frequently so we mirror it
