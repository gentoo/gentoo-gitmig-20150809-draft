# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmms/kmms-0.8_beta1.ebuild,v 1.8 2004/04/08 16:17:59 eradicator Exp $

inherit kde-base

need-kde 3

MY_P=${P/_beta/beta}
S="${WORKDIR}/kmms-0.8beta1"
#SRC_URI="http://luizpaulo.virtualave.net/kmms/${MY_P}.tar.gz"
#HOMEPAGE="http://www.base2.de/"
HOMEPAGE="http://sourceforge.net/projects/kmms/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

DESCRIPTION="A KDE-Taskbar DockApplet control and title display for XMMS."

newdepend "media-sound/xmms"

LICENSE="GPL-2"

KEYWORDS="x86"

PATCHES="${FILESDIR}/${P}-gentoo.diff ${FILESDIR}/${P}-fix-memory-leak.diff"
