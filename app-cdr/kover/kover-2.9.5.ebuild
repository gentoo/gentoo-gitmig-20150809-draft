# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kover/kover-2.9.5.ebuild,v 1.3 2004/06/27 21:16:48 vapier Exp $

inherit kde
need-kde 3

DESCRIPTION="KDE program for CD Cover Creation"
SRC_URI="http://lisas.de/kover/${P}.tar.gz"
HOMEPAGE="http://lisas.de/kover/"

LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

RDEPEND="media-libs/libvorbis
	media-libs/tiff
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	virtual/libc"
DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-devel/libtool
	sys-devel/gettext
	dev-lang/perl
	sys-devel/gcc"
