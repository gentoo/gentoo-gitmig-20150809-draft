# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/root-portal/root-portal-0.4.11.ebuild,v 1.11 2004/09/02 22:49:41 pvdabeel Exp $

inherit debug eutils

DESCRIPTION="A program to draw text and graphs in the root window"
HOMEPAGE="http://root-portal.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
#IUSE="gnome"
IUSE=""

# Build-time dependencies, such as
#    ssl? ( >=openssl-0.9.6b )
#    >=perl-5.6.1-r1
DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	=gnome-base/orbit-0*
	>=gnome-base/gnome-libs-1.4.0
	<gnome-base/gnome-panel-2
	>=dev-libs/libxml-1.8.16 "
# the tabulated section is only needed if Gnome is in USE, but their disable-gnome doesn't work for now.

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
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
