# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/endeavour/endeavour-2.1.20-r1.ebuild,v 1.9 2004/04/06 04:15:45 vapier Exp $

inherit eutils

M=endeavour2-mimetypes
DESCRIPTION="powerful file and image browser"
HOMEPAGE="http://wolfpack.twu.net/Endeavour2/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2
	ftp://wolfpack.twu.net/users/wolfpack/${M}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="app-arch/bzip2
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.14"

src_unpack() {
	unpack ${P}.tar.bz2
	unpack ${M}.tgz

	#need to remove reference to ctypes.h from fio.cpp to make gcc-3.x compile the package
	cd ${S}/endeavour2
	sed -i -e "s:#include <ctype.h>://#include <ctype.h>:" fio.cpp

	if [ "${ARCH}" = "ppc" -o "${ARCH}" = "sparc" -o "${ARCH}" = "sparc64" ]; then
		# This patch fixes inverted color on big endian machines
		einfo "Applying big endian patch..."
		cd ${S}; epatch ${FILESDIR}/${P}-bigendian.diff
	fi
}

src_compile() {
	./configure Linux --prefix=/usr || die
	emake || die "Parallel make failed"
}

src_install() {
	dodoc AUTHORS HACKING INSTALL README TODO

	cd endeavour2

	dobin endeavour2
	bunzip2 endeavour2.1.bz2
	doman endeavour2.1

	dodir /usr/share/endeavour2
	cp -R data/* ${D}/usr/share/endeavour2

	cd images
	insinto /usr/share/icons
	doins endeavour_48x48.xpm image_browser_48x48.xpm icon_trash_48x48.xpm \
		icon_trash_empty_48x48.xpm

	# install mimetypes
	cd ${WORKDIR}/${M}
	mv README README.mimetypes
	dodoc README.mimetypes
	insinto /usr/share/endeavour2/
	doins mimetypes.ini
}
