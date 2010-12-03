# Copyright 2009-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qgoogletranslator/qgoogletranslator-1.2.1.ebuild,v 1.1 2010/12/03 14:29:27 grozin Exp $
EAPI="3"
inherit cmake-utils

DESCRIPTION="GUI for google translate web service"
HOMEPAGE="http://code.google.com/p/qgt/"
SRC_URI="http://qgt.googlecode.com/files/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=x11-libs/qt-gui-4.6"
DEPEND="${RDEPEND}"
