# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gxmame/gxmame-0.31.ebuild,v 1.2 2003/02/13 07:14:01 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GXMame is a frontend for XMame using the GTK library, the goal is to provide the same GUI as mame32."
HOMEPAGE="http://gxmame.sourceforge.net/"
SRC_URI="mirror://sourceforge/gxmame/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="x11-base/xfree
		=x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2*"

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
}
