# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-embed-plugin/xfce4-embed-plugin-0.0.2_pre.ebuild,v 1.1 2012/01/10 09:57:35 ssuominen Exp $

EAPI=4
inherit xfconf

MY_P=${PN}-${PV/_pre/git-17b7aa3}

DESCRIPTION="A plug-in for embedding arbitrary application windows into the Xfce panel"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-embed-plugin"
SRC_URI="http://goodies.xfce.org/_media/projects/panel-plugins/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.20:2
	x11-libs/libX11
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	XFCONF=(
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README THANKS )
}
