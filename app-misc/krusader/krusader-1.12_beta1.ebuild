# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.12_beta1.ebuild,v 1.3 2003/04/05 21:42:14 danarmak Exp $

IUSE=""

inherit kde-base

need-kde 3

MY_P=${P/_/-}
DESCRIPTION="An oldschool Filemanager for KDE"
HOMEPAGE="http:/krusader.sourceforge.net/"
SRC_URI="http://krusader.sourceforge.net/dev/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"
LICENSE="GPL-2"
KEYWORDS="x86"
