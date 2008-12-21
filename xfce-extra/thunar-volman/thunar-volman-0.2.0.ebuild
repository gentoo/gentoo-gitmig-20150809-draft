# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-volman/thunar-volman-0.2.0.ebuild,v 1.9 2008/12/21 12:40:08 flameeyes Exp $

inherit eutils xfce44

xfce44

DESCRIPTION="Thunar volume management"
HOMEPAGE="http://foo-projects.org/~benny/projects/thunar-volman"
SRC_URI="mirror://berlios/xfce-goodies/${P}.tar.bz2"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"

RDEPEND="dev-libs/dbus-glib
	sys-apps/hal
	>=xfce-extra/exo-0.3.2
	>=xfce-base/thunar-${THUNAR_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use xfce-extra/exo hal; then
		ewarn "Volume management requires xfce-extra/exo with hal support. Enable"
		ewarn "hal USE flag and re-emerge xfce-extra/exo."
		die "re-emerge xfce-extra/exo with USE hal"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fix make check.
	echo thunar-volman-settings.desktop.in.in >> po/POTFILES.skip
}

DOCS="AUTHORS ChangeLog NEWS README THANKS"
