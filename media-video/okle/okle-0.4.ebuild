# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/okle/okle-0.4.ebuild,v 1.2 2004/04/09 14:06:01 dholm Exp $

inherit kde-base

need-kde 3

DESCRIPTION="oKle is a KDE frontend to the Ogle DVD player."
HOMEPAGE="http://okle.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=media-video/ogle-0.9.2"
SLOT="0"
IUSE=""

