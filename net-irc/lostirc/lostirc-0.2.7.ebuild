# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/lostirc/lostirc-0.2.7.ebuild,v 1.5 2004/03/23 17:51:55 mholzer Exp $

inherit base

IUSE="kde gnome"
DESCRIPTION="A simple but functional graphical IRC client"
HOMEPAGE="http://lostirc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
S=${WORKDIR}/${P}
DEPEND=">=sys-apps/sed-4*
	>=dev-cpp/gtkmm-2.0
	>=dev-libs/libsigc++-1.2"

src_compile() {
	# patch po/Makefile.in.in
	sed -i -r 's:(^mkinstalldirs = ).*:\1$(MKINSTALLDIRS):' po/Makefile.in.in || die
	local myconf=""
	use kde || myconf="${myconf} --disable-kde"
	use gnome || myconf="${myconf} --disable-gnome"
	econf ${myconf} || die
	base_src_compile make
}

src_install() {
	base_src_install
	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO NEWS
}
