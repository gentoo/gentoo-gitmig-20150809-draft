# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/jefferson/jefferson-3.2.ebuild,v 1.5 2005/01/14 23:50:49 danarmak Exp $

inherit kde

DESCRIPTION="On Screen Display plugin for Noatun"
HOMEPAGE="http://www.freekde.org/neil/jefferson/"
SRC_URI="http://www.freekde.org/neil/jefferson/${P}.tar.bz2"

SLOT="0"
LICENSE="MIT"
KEYWORDS="x86"
IUSE=""

DEPEND="|| ( kde-base/noatun >=kde-base/kdemultimedia-3.0 )"
need-kde 3