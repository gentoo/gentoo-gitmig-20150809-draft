# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdestudio/kdestudio-2.0.0-r2.ebuild,v 1.9 2002/12/09 04:21:15 manson Exp $

PATCHES="${FILESDIR}/${P}-gentoo.diff"
inherit kde-base
IUSE=""
HOMEPAGE="http://www.thekompany.com/projects/kdestudio"
DESCRIPTION="KDE 2.x IDE"
SRC_URI="ftp://ftp.rygannon.com/pub/KDE_Studio/source/${P}.tar.gz"

need-kde 2.1

LICENSE="GPL-2"
KEYWORDS="x86 sparc "
