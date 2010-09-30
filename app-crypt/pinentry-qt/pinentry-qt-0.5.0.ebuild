# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pinentry-qt/pinentry-qt-0.5.0.ebuild,v 1.1 2010/09/30 13:04:01 ssuominen Exp $

EAPI=2
inherit cmake-utils

DESCRIPTION="A simple PIN or passphrase entry dialog"
HOMEPAGE="http://gnupg.org/aegypten2/index.html"
SRC_URI="mirror://gnupg/pinentry/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README THANKS"
