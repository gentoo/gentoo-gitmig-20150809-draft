# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cpugraph/xfce4-cpugraph-0.3.0-r1.ebuild,v 1.4 2007/08/27 13:30:46 gustavoz Exp $

inherit autotools eutils xfce44

xfce44

DESCRIPTION="CPU load panel plugin"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 sparc x86 ~x86-fbsd"

DEPEND=">=xfce-extra/xfce4-dev-tools-${XFCE_MASTER_VERSION}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-sizeof.patch
	epatch "${FILESDIR}"/${P}-asneeded.patch
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
}

xfce44_goodies_panel_plugin
