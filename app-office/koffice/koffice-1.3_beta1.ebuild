# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.3_beta1.ebuild,v 1.3 2003/05/24 11:34:30 brain Exp $
inherit kde-base flag-o-matic

# TODO : mysql support
# other refs from configure: jasper, qt-docs, doxygen, libxml2, libxslt, freetype, fontconfig,
# qsa from trolltech (whatever that is), qt being built with sql support (???)

filter-flags "-fomit-frame-pointer"

need-kde 3

DESCRIPTION="A free, integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/unstable/${PN}-1.2.90/src/${PN}-1.2.90.tar.bz2"

S="$WORKDIR/${PN}-1.2.90"

KEYWORDS="~x86"

DEPEND="$DEPEND
	>=dev-lang/python-2.2.1
	>=media-libs/libart_lgpl-2.3.9
	>=media-gfx/imagemagick-5.4.5
	>=app-text/wv2-0.0.9
	dev-util/pkgconfig
	>=dev-libs/qsa-1.0_pre20030513"

export LIBPYTHON="`python-config --libs`"
export LIBPYTHON="${LIBPYTHON//-L \/usr\/lib\/python2.2\/config}"

need-automake 1.5
need-autoconf 2.5

PATCHES="$FILESDIR/$P-fontconfig-2.2-support.diff"

src_compile() {
	rm -f configure configure.in
	kde_src_compile configure
	kde_src_compile make
}
