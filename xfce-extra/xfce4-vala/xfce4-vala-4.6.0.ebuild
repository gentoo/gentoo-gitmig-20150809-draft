# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-vala/xfce4-vala-4.6.0.ebuild,v 1.2 2010/09/20 10:28:54 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Vala bindings for libxfce4util, libxfce4menu, xfconf, libxfcegui4, exo and libxfce4panel"
HOMEPAGE="http://wiki.xfce.org/vala-bindings/"
SRC_URI="mirror://xfce/src/bindings/${PN}/4.6/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfce4menu-4.6
	>=xfce-base/xfconf-4.6
	>=xfce-base/exo-0.3.100
	<xfce-base/exo-0.5
	>=xfce-base/xfce4-panel-4.6
	>=dev-lang/vala-0.7.1:0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS NEWS README"

# Default src_test doesn't find the "tests" target, tests are not ran
# automatically but the build system. Needs work.
#src_test() {
#	make tests
#	einfo "Tests are compliled but not ran"
#}
