# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmms/kmms-0.8_beta1.ebuild,v 1.5 2003/06/12 21:01:13 msterret Exp $

inherit kde-base

need-kde 3

S="${WORKDIR}/kmms-0.8beta1"
SRC_URI="http://luizpaulo.virtualave.net/kmms/kmms-0.8beta1.tar.gz"
HOMEPAGE="http://www.base2.de/"
DESCRIPTION="A KDE-Taskbar DockApplet control and title display for XMMS." 

newdepend "media-sound/xmms"

LICENSE="GPL-2"

KEYWORDS="x86"

PATCHES="${FILESDIR}/${P}-gentoo.diff ${FILESDIR}/${P}-fix-memory-leak.diff"
