# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/hayes/hayes-1.3.ebuild,v 1.4 2004/04/06 17:55:30 caleb Exp $

inherit kde
need-kde 3

DESCRIPTION="A filesystem-based Playlist for Noatun 2.0"
SRC_URI="http://www.freekde.org/neil/hayes/${P}.tar.bz2"
HOMEPAGE="http://www.freekde.org/neil/hayes/"

LICENSE="MIT"
KEYWORDS="x86"

DEPEND=">=kde-base/kdemultimedia-3.0"
