# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/okle/okle-0.4.ebuild,v 1.4 2004/06/28 20:46:05 mr_bones_ Exp $

inherit kde
need-kde 3

DESCRIPTION="oKle is a KDE frontend to the Ogle DVD player."
HOMEPAGE="http://okle.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=media-video/ogle-0.9.2"
SLOT="0"
IUSE=""
