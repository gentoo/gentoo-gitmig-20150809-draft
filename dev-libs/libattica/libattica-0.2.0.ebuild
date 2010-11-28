# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libattica/libattica-0.2.0.ebuild,v 1.2 2010/11/28 02:13:12 mr_bones_ Exp $

EAPI=3

MY_P="${P#lib}"
MY_PN="${PN#lib}"

inherit cmake-utils

DESCRIPTION="A library providing access to Open Collaboration Services"
HOMEPAGE="http://kde.org/"
SRC_URI="mirror://kde/stable/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="debug"

DEPEND="x11-libs/qt-core:4"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS ChangeLog README)

S="${WORKDIR}/${MY_P}"
