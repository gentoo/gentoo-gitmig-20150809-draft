# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/embryo/embryo-1.0.0_beta3.ebuild,v 1.1 2010/12/17 18:33:30 tommy Exp $

MY_P=${P/_beta/.beta}

inherit enlightenment

DESCRIPTION="load and control programs compiled in embryo language (small/pawn variant)"
SRC_URI="http://download.enlightenment.org/releases/${MY_P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

S=${WORKDIR}/${MY_P}
