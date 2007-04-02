# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-thumbnailers/thunar-thumbnailers-0.2.0.ebuild,v 1.1 2007/04/02 13:34:59 drac Exp $

inherit xfce44

xfce44

DESCRIPTION="Thunar thumbnailers plugin"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-thumbnailers"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}${COMPRESS}"

KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86"
IUSE="dcraw ffmpeg grace tetex"

RDEPEND=">=xfce-base/thunar-${THUNAR_MASTER_VERSION}
	media-gfx/imagemagick
	dcraw? ( media-gfx/dcraw )
	grace? ( sci-visualization/grace )
	tetex? ( app-text/tetex )
	ffmpeg? ( media-video/ffmpegthumbnailer )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}-0.0.1svn-r02578"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable tetex tex) $(use_enable dcraw raw) \
	$(use_enable grace) $(use_enable ffmpeg) --disable-update-mime-database"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_postinst() {
	xfce44_pkg_postinst
	elog "Run /usr/libexec/thunar-vfs-update-thumbnailers-cache-1 as a user to enable
	thumbnailers."
}
