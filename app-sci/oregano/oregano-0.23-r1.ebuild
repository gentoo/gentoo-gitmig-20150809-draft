# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/oregano/oregano-0.23-r1.ebuild,v 1.6 2004/04/19 12:00:56 phosphan Exp $

DESCRIPTION="Oregano is an application for schematic capture and simulation of electrical circuits."
SRC_URI="ftp://ftp.codefactory.se/pub/CodeFactory/software/oregano/${P}.tar.gz"
HOMEPAGE="http://oregano.codefactory.se/"

SLOT="0"
IUSE=""
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4
	>=gnome-base/libglade-0.17 <gnome-base/libglade-2.0.0
	>=gnome-base/gnome-print-0.30
	>=dev-libs/libxml-1.8.17
	>=app-sci/spice-3.5.5"

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
}
