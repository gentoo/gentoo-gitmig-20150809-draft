# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/oregano/oregano-0.23-r1.ebuild,v 1.1 2004/12/27 20:13:35 ribosome Exp $

DESCRIPTION="Oregano is an application for schematic capture and simulation of electrical circuits."
SRC_URI="ftp://ftp.codefactory.se/pub/CodeFactory/software/oregano/${P}.tar.gz"
HOMEPAGE="http://oregano.codefactory.se/"

SLOT="0"
IUSE=""
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4
	>=gnome-base/libglade-0.17 <gnome-base/libglade-2.0.0
	>=gnome-base/gnome-print-0.30
	>=dev-libs/libxml-1.8.17
	>=app-sci/spice-3.5.5"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall
}
