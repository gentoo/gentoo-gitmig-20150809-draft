# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sodipodi/sodipodi-0.24.1-r4.ebuild,v 1.4 2002/07/23 05:18:07 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Vector illustrating application for GNOME"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sodipodi.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=gnome-base/gnome-print-0.30
	>=gnome-extra/gal-0.13-r1
	media-libs/gdk-pixbuf
	bonobo? ( >=gnome-base/bonobo-1.0.9 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-compile.patch
	automake
}

src_compile() {
	local myconf

	# Bonobo support doesn't seem to work.
	use bonobo \
		&& myconf="${myconf} --with-bonobo" \
		|| myconf="${myconf} --without-bonobo"

	use nls || myconf="${myconf} --disable-nls"

	CFLAGS="${CFLAGS} `gnome-config --cflags gdk_pixbuf`"

	econf \
		--enable-gnome \
		--enable-gnome-print \
		${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
