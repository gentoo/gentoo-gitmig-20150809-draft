# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit gnome2
DESCRIPTION="Thinkpad gnome configuration utility for tpctl"
SRC_URI="mirror://sourceforge/tpctl/${P}.tar.gz"
HOMEPAGE="http://tpctl.sourceforge.net/configure-thinkpad.html"
KEYWORDS="~x86 -amd64 -ppc -mips -sparc"

RDEPEND=">=app-laptop/tpctl-4.8
	>=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2.4
	>=sys-devel/gettext-0.11"

DEPEND="${RDEPEND}
		dev-util/pkgconfig"

SLOT="0"
LICENSE="GPL-2"
