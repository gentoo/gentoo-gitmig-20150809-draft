# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksystemlog/ksystemlog-0.3.2-r1.ebuild,v 1.2 2009/10/13 18:33:01 ssuominen Exp $

inherit kde

DESCRIPTION="KSystemLog is a system log viewer for KDE."
SRC_URI="http://annivernet.free.fr/ksystemlog/archives/src/${P}.tar.bz2"
HOMEPAGE="http://annivernet.free.fr/ksystemlog/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-desktop-entry.patch" )
