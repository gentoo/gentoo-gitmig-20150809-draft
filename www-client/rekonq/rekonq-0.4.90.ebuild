# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/rekonq/rekonq-0.4.90.ebuild,v 1.2 2010/05/26 17:20:04 scarabeus Exp $

EAPI=2
WEBKIT_REQUIRED=always
KDE_MINIMAL=4.4
inherit kde4-base

DESCRIPTION="A browser based on qt-webkit"
HOMEPAGE="http://rekonq.sourceforge.net/"
SRC_URI="http://kde-apps.org/CONTENT/content-files/94258-${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=x11-libs/qt-gui-4.6:4[dbus]"

DOCS="AUTHORS ChangeLog TODO"
