# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/bonobo/bonobo-1.0.22.ebuild,v 1.14 2004/01/10 14:57:43 agriffis Exp $

IUSE="nls"

inherit gnome.org libtool

S="${WORKDIR}/${P}"
DESCRIPTION="A set of language and system independant CORBA interfaces"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/oaf-0.6.8
	>=gnome-base/ORBit-0.5.13
	>=gnome-base/gnome-print-0.30
	>=media-libs/gdk-pixbuf-0.6"

DEPEND="${RDEPEND}
	dev-lang/perl
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
