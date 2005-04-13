# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qinx/qinx-1.4.ebuild,v 1.1 2005/04/13 14:15:19 greg_g Exp $

inherit kde eutils

DESCRIPTION="A KDE style inspired by QNX Photon microGUI."
SRC_URI="http://www.usermode.org/code/${P}.tar.bz2"
HOMEPAGE="http://www.usermode.org/code.html"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86 ~alpha -ppc ~sparc ~amd64"
IUSE=""

DEPEND="|| ( kde-base/kwin >=kde-base/kdebase-3.2 )"

need-kde 3.2
