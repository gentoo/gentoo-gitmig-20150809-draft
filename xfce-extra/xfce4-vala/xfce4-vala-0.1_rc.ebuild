# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-vala/xfce4-vala-0.1_rc.ebuild,v 1.1 2009/08/29 21:04:35 ssuominen Exp $

EAPI=2
inherit xfconf

MY_PV=${PV/_rc/-rc}

DESCRIPTION="Vala bindings for libxfce4util, libxfce4menu, xfconf, libxfcegui4, exo and libxfce4panel"
HOMEPAGE="http://wiki.xfce.org/vala-bindings/"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${PN}-${MY_PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfce4menu-4.6
	>=xfce-base/xfconf-4.6
	>=xfce-base/exo-0.3.100
	>=xfce-base/xfce4-panel-4.6
	>=dev-lang/vala-0.7.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}-${MY_PV}

DOCS="AUTHORS NEWS README"
