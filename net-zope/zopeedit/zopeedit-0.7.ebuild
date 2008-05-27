# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zopeedit/zopeedit-0.7.ebuild,v 1.6 2008/05/27 06:37:04 tupone Exp $

inherit distutils

DESCRIPTION="Configurable helper application that drop you into your favorite
editor(s) directly from the ZMI"
HOMEPAGE="http://www.zope.org/Members/Caseman/ExternalEditor/"
SRC_URI="http://www.zope.org/Members/Caseman/ExternalEditor/0.7/zopeedit-${PV}-src.tgz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

S=${WORKDIR}/${P}-src
