# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kbrain/kbrain-0.1.3.ebuild,v 1.10 2004/03/14 10:59:03 mr_bones_ Exp $

inherit kde-base
need-kde 3

PATCHES="${FILESDIR}/${P}-gentoo.diff"
IUSE=""
DESCRIPTION="handy program to create Mind Maps"
SRC_URI="http://cmjartan.freezope.org/kbrain/files/${P}.tar.gz"
HOMEPAGE="http://cmjartan.freezope.org/kbrain"

LICENSE="GPL-2"
KEYWORDS="x86"
