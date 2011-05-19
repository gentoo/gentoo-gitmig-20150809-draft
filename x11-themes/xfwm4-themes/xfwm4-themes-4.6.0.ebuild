# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xfwm4-themes/xfwm4-themes-4.6.0.ebuild,v 1.14 2011/05/19 22:30:00 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Xfce's window manager themes"
HOMEPAGE="http://www.xfce.org/projects/xfwm4/"
SRC_URI="mirror://xfce/src/art/${PN}/4.6/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=xfce-base/xfwm4-4.8"
DEPEND=""

RESTRICT="binchecks strip"

pkg_setup() {
	DOCS=( AUTHORS ChangeLog README TODO )
}
