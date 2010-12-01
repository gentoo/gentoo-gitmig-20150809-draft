# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libresample/libresample-0.1.3.ebuild,v 1.1 2010/12/01 16:59:41 chainsaw Exp $

EAPI=3
inherit eutils

DESCRIPTION="Real-time sampling rate conversion on a liberal license"
HOMEPAGE="https://ccrma.stanford.edu/~jos/resample/Free_Resampling_Software.html"
SRC_URI="http://ccrma.stanford.edu/~jos/gz/${P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

src_install() {
	dolib.a *.a
	insinto /usr/include
	doins include/*.h
}
