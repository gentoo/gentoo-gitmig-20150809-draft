# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yudit/yudit-2.9.2.ebuild,v 1.3 2012/08/13 12:37:53 johu Exp $

DESCRIPTION="free (Y)unicode text editor for all unices"
SRC_URI="http://yudit.org/download/${P}.tar.gz"
HOMEPAGE="http://www.yudit.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

DEPEND="x11-libs/libX11
	>=sys-devel/gettext-0.10"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#Don't strip binaries, let portage do that.
	sed -i "/^INSTALL_PROGRAM/s: -s::" Makefile.conf.in || die "sed failed"
}

src_compile() {
	econf
	#FIXME:
	#-j1 because this app builds a tool called 'mytool' and we need to make
	#sure that it is built before it needs to be used.
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc *.TXT
}
