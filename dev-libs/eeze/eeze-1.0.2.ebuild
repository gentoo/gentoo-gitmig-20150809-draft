# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eeze/eeze-1.0.2.ebuild,v 1.1 2011/08/19 15:17:17 tommy Exp $

inherit enlightenment

DESCRIPTION="library to simplify the use of devices"
HOMEPAGE="http://trac.enlightenment.org/e/wiki/Eeze"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND=">=dev-libs/ecore-1.0.0_beta"
RDEPEND=${DEPEND}
