# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev-meta/kdewebdev-meta-3.5.7.ebuild,v 1.6 2007/08/10 13:54:52 angelos Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdewebdev - merge this to pull in all kdewebdev-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/kfilereplace)
$(deprange $PV $MAXKDEVER kde-base/kimagemapeditor)
$(deprange $PV $MAXKDEVER kde-base/klinkstatus)
$(deprange $PV $MAXKDEVER kde-base/kommander)
$(deprange $PV $MAXKDEVER kde-base/kxsldbg)
$(deprange $PV $MAXKDEVER kde-base/quanta)
"
