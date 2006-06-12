# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pim/gnome-pim-1.4.8.ebuild,v 1.15 2006/06/12 13:40:54 allanonjl Exp $

IUSE="pda"

DESCRIPTION="A personal information manager package for GNOME."
#this version is not available from official gnome repos
SRC_URI="http://me.in-berlin.de/~jroger/gnome-pim/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/gnome-office/gnome-pim.shtml"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ppc"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

DEPEND="${RDEPEND}
	pda? ( <app-pda/gnome-pilot-2 )"

src_unpack() {
	unpack ${A}

	# remove unneeded check that makes it want libxml (#21504)
	cd ${S}
	mv configure.in configure.in.old
	sed -e "s:GNOME_XML_CHECK::" configure.in.old > configure.in
	autoconf || die
}

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}
