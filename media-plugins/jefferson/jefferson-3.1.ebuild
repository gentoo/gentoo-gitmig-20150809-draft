# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/jefferson/jefferson-3.1.ebuild,v 1.4 2003/08/07 03:59:10 vapier Exp $

inherit kde-base
need-kde 3

DESCRIPTION="On Screen Display plugin for Noatun"
HOMEPAGE="http://www.freekde.org/neil/jefferson/"
SRC_URI="http://www.freekde.org/neil/jefferson/${P}.tar.bz2"

LICENSE="MIT"
KEYWORDS="x86"

newdepend ">=kde-base/kdemultimedia-3.0"
