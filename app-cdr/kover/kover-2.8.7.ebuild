# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kover/kover-2.8.7.ebuild,v 1.13 2005/01/01 12:17:53 eradicator Exp $

inherit kde

DESCRIPTION="KDE program for CD Cover Creation"
HOMEPAGE="http://lisas.de/kover/"
SRC_URI="http://lisas.de/kover/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="media-libs/libvorbis"
need-kde 3