# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/rekonq/rekonq-0.3.0.ebuild,v 1.2 2009/11/18 06:39:10 scarabeus Exp $

EAPI=2
WEBKIT_REQUIRED=always
# Seriously non-standart behaviour
#KDE_LINGUAS="da de en en_GB es fr it pt pt_BR ru sr sv tr uk"
#KDE_LINGUAS_DIR="i18n"
KDE_DOC_DIRS="docs"
inherit kde4-base

DESCRIPTION="A browser based on qt-webkit"
HOMEPAGE="http://rekonq.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug handbook"

DEPEND=">=x11-libs/qt-gui-4.5:4[dbus]"

DOCS="AUTHORS ChangeLog TODO"
