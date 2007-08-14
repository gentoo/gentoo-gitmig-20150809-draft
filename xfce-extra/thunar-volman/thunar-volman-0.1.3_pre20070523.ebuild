# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-volman/thunar-volman-0.1.3_pre20070523.ebuild,v 1.9 2007/08/14 18:08:41 corsair Exp $

inherit eutils xfce44

xfce44

DESCRIPTION="Thunar volume management"
HOMEPAGE="http://foo-projects.org/~benny/projects/thunar-volman"
SRC_URI="http://dev.gentooexperimental.org/~drac/distfiles/${P}.tar.bz2"

KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~ppc ppc64 sparc x86"
IUSE="debug"

RDEPEND="dev-libs/dbus-glib
	sys-apps/hal
	>=xfce-extra/exo-0.3.2
	>=xfce-base/thunar-${THUNAR_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use xfce-extra/exo hal; then
		ewarn "Volume management requires exo with hal support. Enable"
		ewarn "hal USE flag and re-emerge exo."
		die "re-emerge exo with USE hal"
	fi
}

DOCS="AUTHORS ChangeLog NEWS README THANKS"
