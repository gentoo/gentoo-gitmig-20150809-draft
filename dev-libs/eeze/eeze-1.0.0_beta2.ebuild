# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eeze/eeze-1.0.0_beta2.ebuild,v 1.1 2010/11/18 14:25:30 tommy Exp $

MY_P=${P/_beta/.beta}

inherit enlightenment

DESCRIPTION="library to simplify the use of devices"
HOMEPAGE="http://trac.enlightenment.org/e/wiki/Eeze"
SRC_URI="http://download.enlightenment.org/releases/${MY_P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND=">=dev-libs/ecore-1.0.0_beta"
RDEPEND=${DEPEND}
S=${WORKDIR}/${MY_P}
