# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sodipodi/sodipodi-0.25.ebuild,v 1.1 2002/10/19 00:10:25 foser Exp $

IUSE="xml nls bonobo"

S=${WORKDIR}/${P}
DESCRIPTION="Vector illustrating application for GNOME"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sodipodi.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/gnome-print-0.35
	>=gnome-extra/gal-0.13
	media-libs/gdk-pixbuf
	bonobo? ( gnome-base/bonobo )
	xml? ( dev-libs/libxml2 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	
	patch -d ${S}/src/bonobo -p0 < ${FILESDIR}/bonobo-makefile-fix.patch
}

src_compile() {
	local myconf

	# Bonobo seems really brokenF
	myconf="${myconf} --without-bonobo"

#	use bonobo \
#		&& myconf="${myconf} --with-bonobo" \
#		|| myconf="${myconf} --without-bonobo"

	use xml2 \
		&& myconf="${myconf} --with-gnome-xml2" \
		|| myconf="${myconf} --without-gnome-xml2"

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
