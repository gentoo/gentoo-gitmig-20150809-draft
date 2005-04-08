# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdiff3/kdiff3-0.9.88.ebuild,v 1.5 2005/04/08 17:09:13 corsair Exp $

inherit kde

DESCRIPTION="KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdiff3/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc sparc ppc64"
IUSE=""

RDEPEND="sys-apps/diffutils"

need-kde 3
