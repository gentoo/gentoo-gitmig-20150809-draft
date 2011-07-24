# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/lpsolve/lpsolve-5.5.2.0.ebuild,v 1.1 2011/07/24 11:43:57 scarabeus Exp $

EAPI=4

DESCRIPTION="Mixed Integer Linear Programming (MILP) solver"
HOMEPAGE="http://sourceforge.net/projects/lpsolve/"
SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="sci-libs/colamd"
RDEPEND="${DEPEND}"
