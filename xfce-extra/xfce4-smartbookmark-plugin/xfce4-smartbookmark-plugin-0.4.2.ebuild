# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-smartbookmark-plugin/xfce4-smartbookmark-plugin-0.4.2.ebuild,v 1.5 2012/04/02 11:57:35 ssuominen Exp $

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Smart bookmark plug-in for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-smartbookmark-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

COMMON_DEPEND=">=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8"
RDEPEND="${COMMON_DEPEND}
	xfce-base/xfce-utils"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-xfce48.patch )

	XFCONF=(
		--disable-static
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog README )
}

src_prepare() {
	sed -i -e 's:bugs.debian:bugs.gentoo:g' src/smartbookmark.c || die
	xfconf_src_prepare
}
