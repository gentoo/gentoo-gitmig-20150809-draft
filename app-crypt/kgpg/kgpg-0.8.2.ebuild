# Copyright 1999-2002 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License, v2 or later 
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kgpg/kgpg-0.8.2.ebuild,v 1.1 2002/10/24 17:47:14 hannes Exp $
# 2002/08/29 21:41 MET Simon Keimer 

PATCHES="${FILESDIR}/${P}-gentoo.diff"
inherit kde-base 
need-kde 3 

IUSE=""
DESCRIPTION="KDE integration for GnuPG" 
SRC_URI="http://devel-home.kde.org/~kgpg/src/${P}.tar.gz" 
HOMEPAGE="http://devel-home.kde.org/~kgpg/index.html" 
LICENSE="GPL-2" 
KEYWORDS="~x86" 

newdepend "app-crypt/gnupg"
