# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellsun/gkrellsun-1.0.0-r1.ebuild,v 1.1 2007/02/21 16:52:09 lack Exp $

inherit multilib

IUSE="nls"
DESCRIPTION="A GKrellM plugin that shows sunrise and sunset times."
HOMEPAGE="http://gkrellsun.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkrellsun/${P}.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc sparc x86"

DEPEND="=app-admin/gkrellm-2*
	nls? ( sys-devel/gettext )"

src_compile() {
	use nls && myconf="$myconf enable_nls=1"
	emake ${myconf}
}

src_install () {
	make DESTDIR="${D}" PREFIX="/usr" PLUGINDIR="${D}/usr/$(get_libdir)/gkrellm2/plugins" ${myconf} install
	dodoc README AUTHORS COPYING
}
