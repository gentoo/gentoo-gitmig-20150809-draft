# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-timer-plugin/xfce4-timer-plugin-0.6.2.ebuild,v 1.1 2011/06/19 06:23:02 angelos Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A simple timer plug-in for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-timer-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.6/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND=">=xfce-base/xfce4-panel-4.8
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/libxfce4util-4.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	DOCS=( AUTHORS ChangeLog README TODO )
}
