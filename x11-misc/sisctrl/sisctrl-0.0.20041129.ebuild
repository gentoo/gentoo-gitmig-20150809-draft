# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/sisctrl/sisctrl-0.0.20041129.ebuild,v 1.1 2004/12/05 01:01:09 pyrania Exp $

IUSE=""

DESCRIPTION="sisctrl is a tool that allows you to tune SiS drivers from X"
HOMEPAGE="http://www.winischhofer.net/linuxsis630.shtml"
SRC_URI="http://www.winischhofer.net/sis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="virtual/x11
	 >=dev-libs/glib-2.0
	 >=x11-libs/gtk+-2.0"

DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}

