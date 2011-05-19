# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-clipman-plugin/xfce4-clipman-plugin-1.1.3.ebuild,v 1.11 2011/05/19 21:26:46 ssuominen Exp $

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="A clipboard manager plug-in for the Xfce panel"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-clipman-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.16:2
	dev-libs/libunique:1
	>=gnome-base/libglade-2.6:2.0
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8
	>=xfce-base/xfconf-4.8
	>=xfce-base/exo-0.6"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${PN}-1.1.1-exo.patch )
	XFCONF=( $(use_enable debug) )
	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}

src_prepare() {
	sed -i \
		-e "/imagesdir/s:xfce4/doc:doc/${PF}/html:" \
		-e "/TARGET_DIR/s:xfce4/doc:doc/${PF}/html:" \
		docs/manual/*/{,images/}Makefile.am || die

	xfconf_src_prepare
}
