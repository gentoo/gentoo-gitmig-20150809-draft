# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdestudio/kdestudio-2.0.0-r2.ebuild,v 1.10 2003/02/13 11:57:30 vapier Exp $

PATCHES="${FILESDIR}/${P}-gentoo.diff"
inherit kde-base
IUSE=""
HOMEPAGE="http://www.thekompany.com/projects/kdestudio"
DESCRIPTION="KDE 2.x IDE"
SRC_URI="ftp://ftp.rygannon.com/pub/KDE_Studio/source/${P}.tar.gz"

need-kde 2.1

LICENSE="GPL-2"
KEYWORDS="x86 sparc "
