# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-thumbnailers/thunar-thumbnailers-0.4.1.ebuild,v 1.10 2010/12/25 08:52:36 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="This package has been replaced. Use xfce-extra/tumbler instead soon as possible."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE="ffmpeg grace latex raw"

RDEPEND="xfce-base/thunar
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
	app-arch/unzip
	raw? ( media-gfx/raw-thumbnailer media-gfx/dcraw )
	grace? ( sci-visualization/grace )
	latex? ( virtual/latex-base )
	ffmpeg? ( media-video/ffmpegthumbnailer )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		$(use_enable latex tex)
		$(use_enable raw)
		$(use_enable grace)
		$(use_enable ffmpeg)
		--disable-update-mime-database
		)
}
