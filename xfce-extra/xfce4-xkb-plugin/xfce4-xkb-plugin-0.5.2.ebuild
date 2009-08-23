# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xkb-plugin/xfce4-xkb-plugin-0.5.2.ebuild,v 1.1 2009/08/23 16:09:48 ssuominen Exp $

inherit xfconf

DESCRIPTION="XKB layout switching panel plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6
	xfce-base/xfce4-panel
	xfce-base/libxfce4util
	xfce-base/libxfcegui4
	<x11-libs/libxklavier-4
	x11-libs/libwnck"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	x11-proto/kbproto
	gnome-base/librsvg"
