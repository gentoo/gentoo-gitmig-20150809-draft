# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Felix Kurth <felix@fkurth.de>
# $Header: /var/cvsroot/gentoo-x86/dev-tex/foiltex/foiltex-2.1.3.ebuild,v 1.2 2003/06/12 20:43:18 msterret Exp $

inherit latex-package

S=${WORKDIR}/foiltex
DESCRIPTION="LaTeX package used to create foils and slides"
SRC_URI="ftp://ftp.dante.de/tex-archive/macros/latex/contrib/supported/foiltex.tar.gz"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/foiltex.html"
LICENSE="as-is"
#for License details see /usr/share/doc/latex-foiltex-2.1.3/foiltex.ins
SLOT="0"
KEYWORDS="x86 ppc sparc "


src_install () {
latex-package_src_doinstall all
cd ${S}
dodoc readme.flt
}
