# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/endeavour/endeavour-2.3.3.ebuild,v 1.5 2004/04/06 04:16:24 vapier Exp $

inherit eutils

M=endeavour2-mimetypes
DESCRIPTION="Powerful file and image browser"
HOMEPAGE="http://wolfpack.twu.net/Endeavour2/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2
	ftp://wolfpack.twu.net/users/wolfpack/${M}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="app-arch/bzip2
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.14"

src_unpack() {
	unpack ${P}.tar.bz2
	epatch ${FILESDIR}/endeavour_gcc33_fix
	unpack ${M}.tgz
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
