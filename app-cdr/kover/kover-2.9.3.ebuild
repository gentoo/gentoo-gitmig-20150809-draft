# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kover/kover-2.9.3.ebuild,v 1.1 2003/06/17 13:04:12 pauldv Exp $

inherit kde-base || die

need-kde 3

IUSE=""
DESCRIPTION="KDE program for CD Cover Creation"
SRC_URI="http://lisas.de/${PN}/${P}.tar.gz"
HOMEPAGE="http://lisas.de/kover"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

newdepend "media-libs/libvorbis"
newdepend "media-libs/tiff"
newdepend "media-libs/jpeg"
newdepend "media-libs/libpng"
newdepend "sys-libs/zlib"
