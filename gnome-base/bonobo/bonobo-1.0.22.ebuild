# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/bonobo/bonobo-1.0.22.ebuild,v 1.3 2003/01/04 12:44:07 foser Exp $

IUSE="nls"

inherit gnome.org libtool

S="${WORKDIR}/${P}"
DESCRIPTION="A set of language and system independant CORBA interfaces"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/oaf-0.6.8
	>=gnome-base/ORBit-0.5.13
	>=gnome-base/gnome-print-0.30"

DEPEND="${RDEPEND}
	sys-devel/perl
	nls? ( sys-devel/gettext 
	>=dev-util/intltool-0.11 )"

src_compile() {
	#libtoolize to fix relink bug
	elibtoolize

	local myconf=""
	use nls || myconf="${myconf} --disable-nls"
  
	econf ${myconf} || die

	make || die # make -j 4 didn't work
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
}

