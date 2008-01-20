# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksynaptics/ksynaptics-0.3.3.ebuild,v 1.5 2008/01/20 18:51:23 angelos Exp $

inherit kde

DESCRIPTION="synaptics touchpad configuration tool"
HOMEPAGE="http://qsynaptics.sourceforge.net/"
SRC_URI="http://qsynaptics.sourceforge.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=x11-libs/libsynaptics-0.14.6c"
RDEPEND="${DEPEND}"

need-kde 3.1
