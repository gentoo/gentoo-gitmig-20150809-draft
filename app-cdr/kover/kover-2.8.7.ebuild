# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kover/kover-2.8.7.ebuild,v 1.6 2003/06/09 13:35:17 seemant Exp $

inherit kde-base || die

need-kde 3

IUSE=""
DESCRIPTION="KDE program for CD Cover Creation"
SRC_URI="http://lisas.de/${PN}/${P}.tar.gz"
HOMEPAGE="http://lisas.de/kover"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

newdepend "media-libs/libvorbis"

