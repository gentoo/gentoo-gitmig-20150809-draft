# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kover/kover-2.8.7.ebuild,v 1.7 2003/06/25 22:37:47 vapier Exp $

inherit kde-base

need-kde 3

DESCRIPTION="KDE program for CD Cover Creation"
SRC_URI="http://lisas.de/kover/${P}.tar.gz"
HOMEPAGE="http://lisas.de/kover/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"

newdepend "media-libs/libvorbis"
