# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/quadkonsole/quadkonsole-0.1.ebuild,v 1.3 2010/11/01 21:48:40 ssuominen Exp $

EAPI=2
inherit kde4-base

MY_P=${PN}4-${PV}

DESCRIPTION="Quadkonsole provides a grid of Konsole terminals"
HOMEPAGE="http://kb.ccchl.de/quadkonsole4/"
SRC_URI="http://kb.ccchl.de/${PN}4/${MY_P}.tar.lzma"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=kde-base/konsole-${KDE_MINIMAL}"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

DOCS="AUTHORS ChangeLog"

PATCHES=( "${FILESDIR}/${P}-desktop_entry.patch" )

S=${WORKDIR}/${MY_P}
