# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table-array30/ibus-table-array30-1.2.0.20090729.ebuild,v 1.1 2009/09/21 23:52:52 matsuu Exp $

EAPI="2"
inherit cmake-utils

MY_P="${P}-Source"
DESCRIPTION="an Array30 Chinese input method for ibus."
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-i18n/ibus-table-1.1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS ChangeLog README RELEASE-NOTES.txt"
