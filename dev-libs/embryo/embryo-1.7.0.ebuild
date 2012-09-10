# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/embryo/embryo-1.7.0.ebuild,v 1.2 2012/09/10 23:30:40 vapier Exp $

inherit enlightenment

DESCRIPTION="load and control programs compiled in embryo language (small/pawn variant)"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

KEYWORDS="~amd64 ~arm ~x86"
IUSE="static-libs"

DEPEND=">=dev-libs/eina-1.7.0"
RDEPEND=${DEPEND}
