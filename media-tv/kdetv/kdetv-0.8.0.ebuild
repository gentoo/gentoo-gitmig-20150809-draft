# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kdetv/kdetv-0.8.0.ebuild,v 1.4 2004/05/18 23:09:56 caleb Exp $

inherit kde
DEPEND=">=media-libs/zvbi-0.2.4"
need-kde 3

DESCRIPTION="A TV application for KDE"
HOMEPAGE="http://www.kwintv.org/"
SRC_URI="http://dziegel.free.fr/releases/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

