# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/oregano/oregano-0.23-r1.ebuild,v 1.2 2002/09/23 04:25:44 blocke Exp $

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.codefactory.se/pub/CodeFactory/software/oregano/${P}.tar.gz"
DESCRIPTION="Oregano is an application for schematic capture and simulation of electrical circuits."
HOMEPAGE="http://oregano.codefactory.se/"

DEPEND="=x11-libs/gtk+-1.2*
		>=gnome-base/gnome-libs-1.4
		>=gnome-base/libglade-0.17 <gnome-base/libglade-2.0.0
		>=gnome-base/gnome-print-0.30
		>=dev-libs/libxml-1.8.17
		>=app-sci/spice-3.5.5"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
}
