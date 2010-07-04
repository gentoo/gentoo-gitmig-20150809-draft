# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mousepad/mousepad-0.2.16-r1.ebuild,v 1.6 2010/07/04 09:19:13 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="A simple text editor for Xfce"
HOMEPAGE="http://www.xfce.org/projects/mousepad/"
SRC_URI="mirror://xfce/src/apps/${PN}/0.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfcegui4-4.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
	PATCHES=( "${FILESDIR}/${P}-resensitize-find-button.patch"
		"${FILESDIR}/${P}-fix-first-replace.patch" )
}
