# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kover/kover-2.9.3.ebuild,v 1.8 2004/04/03 14:57:41 aliz Exp $

inherit kde
need-kde 3

DESCRIPTION="KDE program for CD Cover Creation"
SRC_URI="http://lisas.de/kover/${P}.tar.gz"
HOMEPAGE="http://lisas.de/kover/"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~amd64"

DEPEND="media-libs/libvorbis
	media-libs/tiff
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib"
