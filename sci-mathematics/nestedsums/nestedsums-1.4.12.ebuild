# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/nestedsums/nestedsums-1.4.12.ebuild,v 1.1 2011/01/16 12:27:49 grozin Exp $
EAPI="4"
DESCRIPTION="A GiNaC-based library for symbolic expansion of certain transcendental functions."
HOMEPAGE="http://wwwthep.physik.uni-mainz.de/~stefanw/nestedsums/"
IUSE=""
SRC_URI="http://wwwthep.physik.uni-mainz.de/~stefanw/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RDEPEND=">=sci-mathematics/ginac-1.5"
DEPEND="${RDEPEND}"
