# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/endeavour/endeavour-2.1.14.ebuild,v 1.3 2002/07/25 16:55:21 seemant Exp $

M=endeavour2-mimetypes
S=${WORKDIR}/${P}
DESCRIPTION="This is a powerful file and image browser"
HOMEPAGE="http://wolfpack.twu.net/Endeavour2/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2
	ftp://wolfpack.twu.net/users/wolfpack/${M}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10
	>=media-gfx/iv-0.1.9"

src_unpack() {
	unpack ${P}.tar.bz2
	unpack ${M}.tgz
}

src_compile() {
	cd ${P}
	./configure Linux \
		--prefix=/usr
	emake || die "Parallel make failed"
}


src_install () {
	dobin endeavour2/endeavour2
	doman endeavour2/endeavour2.1
	dodir /usr/share/icons
	insinto /usr/share/icons
	doins endeavour2/images/endeavour_48x48.xpm \
	endeavour2/images/image_browser_48x48.xpm \
	endeavour2/images/icon_trash_48x48.xpm \
	endeavour2/images/icon_trash_empty_48x48.xpm
	dodir /usr/share/endeavour2
	cp -R endeavour2/data/* ${D}/usr/share/endeavour2
	dodoc AUTHORS HACKING INSTALL README TODO
	
	# install mimetypes
	cd ${WORKDIR}/${M}
	mv README README.mimetypes
	dodoc README.mimetypes
	insinto /usr/share/endeavour2/
	doins mimetypes.ini
}
