# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kxdocker-resources/kxdocker-resources-1.0.0.ebuild,v 1.1 2006/02/26 06:23:59 dragonheart Exp $

inherit kde

DESCRIPTION="KXDocker resources are base themes to help run KXDocker (the KDE animated docker)"
HOMEPAGE="http://www.xiaprojects.com/www/prodotti/kxdocker/main.php"
SRC_URI="http://www.xiaprojects.com/www/downloads/files/kxdocker/1.0.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# note - arch independ package - only contains png and wav files

IUSE=""

need-kde 3.2
