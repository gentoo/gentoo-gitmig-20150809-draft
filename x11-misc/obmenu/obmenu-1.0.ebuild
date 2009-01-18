# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obmenu/obmenu-1.0.ebuild,v 1.7 2009/01/18 16:46:09 maekke Exp $

inherit distutils

DESCRIPTION="Menu editor designed for openbox"
HOMEPAGE="http://obmenu.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.6"
