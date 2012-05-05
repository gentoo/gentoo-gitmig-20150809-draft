# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-vala/xfce4-vala-4.8.1.ebuild,v 1.2 2012/05/05 07:42:41 mgorny Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Vala bindings for the Xfce desktop environment"
HOMEPAGE="http://wiki.xfce.org/vala-bindings"
SRC_URI="mirror://xfce/src/bindings/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/vala:0.12
	>=xfce-base/exo-0.6
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8
	>=xfce-base/xfconf-4.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	export VALAC="$(type -P valac-0.12)"

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
