# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/root-portal/root-portal-0.5.0.ebuild,v 1.3 2004/01/15 16:36:02 tseng Exp $

inherit debug

DESCRIPTION="A program to draw text and graphs in the root window"
HOMEPAGE="http://root-portal.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gnome"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2.0
	>=x11-libs/libzvt-2.0
	>=gnome-base/ORBit2-2.0
	>=libgnomeui-2.0
	>=gnome-panel-2.0
	>=dev-libs/libxml2-2.0"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	local myconf="--enable-debug --enable-test --enable-crash-debug"
	## Theres an upstream bug (filed) that disables this. when the next version is out, uncomment theese lines and it should work


#	use gnome && myconf="${myconf} --enable-gnometext-builtin --enable-shell-builtin"
# 	use gnome || myconf="${myconf} --without-gnome --without-gnome-libs --disable-gnometext-builtin --disable-shell-builtin"

	econf \
		--enable-gnometext \
		--enable-shell \
		--enable-console \
		--enable-fifo \
		--enable-filetail \
		--enable-graph \
		--enable-process-builtin \
		--enable-modifier \
		--enable-networkload \
		--enable-remote \
		--enable-roottext \
		--enable-systemload \
		--enable-consoledump \
		${myconf} \
		|| die "configure failure. please file a bugreport"
	emake || die "compile failure. please file a bugreport"
}

src_install() {
	einstall || die
	dodoc PACKAGING README NEWS ChangeLog BUGS AUTHORS README.help TODO
}
