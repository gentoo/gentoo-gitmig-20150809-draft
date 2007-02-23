# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellfire/gkrellfire-0.3.3.ebuild,v 1.1 2007/02/23 16:29:13 lack Exp $

inherit multilib

DESCRIPTION="Cpu load flames for GKrellM 2"
HOMEPAGE="http://people.freenet.de/thomas-steinke"
SRC_URI="http://people.freenet.de/thomas-steinke/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
RDEPEND="=app-admin/gkrellm-2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	dodoc Changelog COPYING README

	exeinto /usr/$(get_libdir)/gkrellm2/plugins
	doexe gkrellfire.so
}
