# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-thumbnailers/thunar-thumbnailers-0.4.1.ebuild,v 1.8 2009/10/08 17:20:34 darkside Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Thunar thumbnailers plugin"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-thumbnailers"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE="ffmpeg grace latex raw"

RDEPEND="xfce-base/thunar
	media-gfx/imagemagick
	app-arch/unzip
	raw? ( media-gfx/raw-thumbnailer media-gfx/dcraw )
	grace? ( sci-visualization/grace )
	latex? ( virtual/latex-base )
	ffmpeg? ( media-video/ffmpegthumbnailer )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF="$(use_enable latex tex)
		$(use_enable raw)
		$(use_enable grace)
		$(use_enable ffmpeg)
		--disable-update-mime-database"
	DOCS="AUTHORS ChangeLog README"
}
