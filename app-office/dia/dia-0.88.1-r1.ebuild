# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.88.1-r1.ebuild,v 1.13 2003/09/08 11:27:52 msterret Exp $

DESCRIPTION="Diagram Creation Program"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/gnome-office/dia.shtml"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
IUSE="nls cups gnome bonobo"

RDEPEND=">=dev-libs/libxml-1.8.15
	>=media-libs/gdk-pixbuf-0.16.0-r4
	>=dev-libs/popt-1.5
	bonobo? ( >=gnome-base/bonobo-1.0.9-r1 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"
#	python? ( dev-lang/python-2.0 )"

src_compile() {
	local myconf
	use gnome && myconf="--enable-gnome"
	use bonobo && myconf="--enable-gnome --enable-bonobo"
#	use python && myconf="${myconf} --with-python"
	use nls || myconf="${myconf} --disable-nls"
	use cups || myconf="${myconf} --disable-gnome-print"
	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
}
