# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/oregano/oregano-0.23-r1.ebuild,v 1.3 2005/01/10 14:05:16 gustavoz Exp $

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
	>=sci-electronics/spice-3.5.5"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall
}
