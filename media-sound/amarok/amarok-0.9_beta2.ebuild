# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-0.9_beta2.ebuild,v 1.1 2004/02/22 23:04:21 lanius Exp $

inherit kde-base
need-kde 3

MY_P=${P/_/-}

DESCRIPTION="amaroK is a media player for KDE"
HOMEPAGE="http://amarok.sourceforge.net/"
SRC_URI="mirror://sourceforge/amarok/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
S=${WORKDIR}/${MY_P}
IUSE="gstreamer"

newdepend ">=kde-base/kdemultimedia-3.2
	   gstreamer? ( media-libs/gstreamer
			media-libs/gst-plugins )"

src_compile() {
	PREFIX=`kde-config --prefix`
	kde_src_compile myconf configure || die
	make || die
}
