# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-plugins/jefferson/jefferson-3.1.ebuild,v 1.3 2003/02/13 12:58:23 vapier Exp $

inherit kde-base

need-kde 3

IUSE=""
KEYWORDS="x86"
LICENSE="MIT"
newdepend ">=kde-base/kdemultimedia-3.0"

DESCRIPTION="On Screen Display plugin for Noatun"
SRC_URI="http://www.freekde.org/neil/jefferson/${P}.tar.bz2"
HOMEPAGE="http://www.freekde.org/neil/jefferson/"
