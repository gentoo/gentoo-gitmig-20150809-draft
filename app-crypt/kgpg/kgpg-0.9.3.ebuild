# Copyright 1999-2002 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License, v2 or later 
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kgpg/kgpg-0.9.3.ebuild,v 1.1 2002/11/26 14:42:16 hannes Exp $

inherit kde-base 
need-kde 3 

IUSE=""
DESCRIPTION="KDE integration for GnuPG" 
SRC_URI="http://devel-home.kde.org/~kgpg/src/${P}.tar.gz" 
HOMEPAGE="http://devel-home.kde.org/~kgpg/index.html" 
LICENSE="GPL-2" 
KEYWORDS="~x86" 

newdepend "app-crypt/gnupg"
