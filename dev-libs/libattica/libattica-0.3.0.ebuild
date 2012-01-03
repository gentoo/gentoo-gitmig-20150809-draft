# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libattica/libattica-0.3.0.ebuild,v 1.1 2012/01/03 17:02:52 johu Exp $

EAPI=4

MY_P="${P#lib}"
MY_PN="${PN#lib}"

inherit cmake-utils

DESCRIPTION="A library providing access to Open Collaboration Services"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="debug"

DEPEND="x11-libs/qt-core:4"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS ChangeLog README)

S="${WORKDIR}/${MY_P}"
