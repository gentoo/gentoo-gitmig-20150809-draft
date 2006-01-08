# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yakuake/yakuake-2.7.3.ebuild,v 1.2 2006/01/08 09:36:48 josejx Exp $

inherit kde

DESCRIPTION="Yet another Kuake KDE terminal emulator"
HOMEPAGE="http://yakuake.uv.ro/"
SRC_URI="http://download.softpedia.com/linux/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="|| ( kde-base/konsole
	kde-base/kdebase )"

need-kde 3.3

