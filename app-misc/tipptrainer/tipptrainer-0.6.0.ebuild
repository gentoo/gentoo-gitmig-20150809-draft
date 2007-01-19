# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tipptrainer/tipptrainer-0.6.0.ebuild,v 1.5 2007/01/19 14:19:56 masterdriverz Exp $

DESCRIPTION="A touch typing trainer (German/English)"
HOMEPAGE="http://tipptrainer.pingos.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND=">=dev-libs/glib-1.2.7
	=x11-libs/wxGTK-2.4*"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
