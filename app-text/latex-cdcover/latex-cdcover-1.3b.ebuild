# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/latex-cdcover/latex-cdcover-1.3b.ebuild,v 1.3 2003/02/13 09:40:08 vapier Exp $

inherit latex-package

S=${WORKDIR}/cdcover
DESCRIPTION="LaTeX package used to create CD case covers."
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="ftp://ibiblio.org/pub/packages/TeX/macros/latex/contrib/supported/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

# checksum from official ftp site changes frequently so we mirror it
