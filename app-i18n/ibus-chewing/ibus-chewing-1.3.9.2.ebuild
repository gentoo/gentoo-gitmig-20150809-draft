# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-chewing/ibus-chewing-1.3.9.2.ebuild,v 1.1 2011/04/02 02:05:44 matsuu Exp $

EAPI="3"
inherit cmake-utils

MY_P="${P}-Source"
DESCRIPTION="The Chewing IMEngine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="x11-libs/libXtst
	>=app-i18n/ibus-1.1
	>=dev-libs/libchewing-0.3.2
	x11-libs/gtk+:2
	dev-util/gob:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

CMAKE_IN_SOURCE_BUILD=1

PATCHES=( "${FILESDIR}/${P}-cflags.patch" )

DOCS="AUTHORS ChangeLog ChangeLog.prev README RELEASE-NOTES.txt USER-GUIDE"
