# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.90-r1.ebuild,v 1.4 2002/08/30 12:22:12 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Diagram Creation Program"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/gnome-office/dia.shtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND=">=dev-libs/libxml-1.8.15
	>=media-libs/gdk-pixbuf-0.18.0
	>=dev-libs/popt-1.6.3
	>=dev-libs/libunicode-0.4-r1
	bonobo? ( >=gnome-base/bonobo-1.0.19-r1 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"
#	python? ( dev-lang/python-2.0 )"



src_compile() {
	local myconf

	use gnome && myconf="--enable-gnome"

	use bonobo myconf="--enable-gnome --enable-bonobo"

#	use python && myconf="${myconf} --with-python"

	use nls || myconf="${myconf} --disable-nls"
 
    # enable-gnome-print not recoomended

	econf ${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
}
