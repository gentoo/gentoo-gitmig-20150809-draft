# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-plugins/jefferson/jefferson-3.1.ebuild,v 1.2 2002/11/02 10:15:37 hannes Exp $

inherit kde-base

need-kde 3

IUSE=""
KEYWORDS="x86"
LICENSE="MIT"
newdepend ">=kde-base/kdemultimedia-3.0"

DESCRIPTION="On Screen Display plugin for Noatun"
SRC_URI="http://www.freekde.org/neil/jefferson/${P}.tar.bz2"
HOMEPAGE="http://www.freekde.org/neil/jefferson/"
