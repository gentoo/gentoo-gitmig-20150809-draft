# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e16keyedit/e16keyedit-0.2.ebuild,v 1.21 2005/01/29 05:35:49 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Key binding editor for enlightenment 16"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/e16utils/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="virtual/x11
	>=x11-wm/enlightenment-0.16
	=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:-lgdbm -lgdk_imlib::' Makefile
	epatch ${FILESDIR}/${PV}-fullscreen.patch
}

src_compile() {
	emake CC=$(tc-getCC) EXTRA_CFLAGS="${CFLAGS}" || die
}

src_install() {
	 dobin e16keyedit || die
	 dodoc README ChangeLog AUTHORS
}
