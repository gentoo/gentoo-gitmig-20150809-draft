# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.25_beta1.ebuild,v 1.1 2003/08/26 14:35:31 caleb Exp $

IUSE=""

inherit kde-base
need-kde 3

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An oldschool Filemanager for KDE"
HOMEPAGE="http:/krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
