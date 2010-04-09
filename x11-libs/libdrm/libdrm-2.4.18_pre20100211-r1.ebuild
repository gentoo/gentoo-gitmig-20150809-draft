# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdrm/libdrm-2.4.18_pre20100211-r1.ebuild,v 1.2 2010/04/09 10:18:59 fauli Exp $

EAPI=2
SNAPSHOT="yes"
inherit x-modular

EGIT_REPO_URI="git://anongit.freedesktop.org/git/mesa/drm"

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="http://dri.freedesktop.org/"
if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
fi

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="test" # see bug #236845

RDEPEND="dev-libs/libpthread-stubs"
DEPEND="${RDEPEND}"

PATCHES=(
	# Fixes buidling of x11-drivers/xf86-video-openchrome, Gentoo bug 298352,
	# upstream bug 26994
	"${FILESDIR}"/2.4.18-0001-datatypes.patch
	)

pkg_setup() {
	# Fails to build on ARM if dev-libs/libatomic_ops is installed, bug 297630
	CONFIGURE_OPTIONS="--enable-udev --enable-nouveau-experimental-api $(use_enable !arm intel) $(use_enable !arm radeon)"
}

pkg_postinst() {
	x-modular_pkg_postinst

	ewarn "libdrm's ABI may have changed without change in library name"
	ewarn "Please rebuild media-libs/mesa, x11-base/xorg-server and"
	ewarn "your video drivers in x11-drivers/*."
}
