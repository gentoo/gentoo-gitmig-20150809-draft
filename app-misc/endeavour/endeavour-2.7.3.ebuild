# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/endeavour/endeavour-2.7.3.ebuild,v 1.8 2011/08/13 07:35:26 xarthisius Exp $

EAPI=1
inherit eutils

M=endeavour2-mimetypes
DESCRIPTION="Powerful file and image browser"
HOMEPAGE="http://wolfpack.twu.net/Endeavour2/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2
	ftp://wolfpack.twu.net/users/wolfpack/${M}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="joystick"

DEPEND="app-arch/bzip2
	x11-libs/gtk+:1
	>=media-libs/imlib-1.9.14
	x11-libs/libX11
	virtual/opengl
	joystick? ( media-libs/libjsw )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-amd64-gtk-flags.patch" \
		"${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	./configure Linux --prefix=/usr $(use_enable joystick libjsw) || die
	emake || die "Parallel make failed"
}

src_install() {
	dodoc AUTHORS HACKING README TODO

	cd endeavour2
	dobin endeavour2 || die
	bunzip2 endeavour2.1.bz2
	doman endeavour2.1

	dodir /usr/share/endeavour2
	cp -R data/* "${D}"/usr/share/endeavour2 || die
	dodir /usr/share/endeavour2/icons/
	cp -R images/* "${D}"/usr/share/endeavour2/icons/

	cd images
	insinto /usr/share/icons
	doins endeavour_48x48.xpm image_browser_48x48.xpm icon_trash_48x48.xpm \
		icon_trash_empty_48x48.xpm

	# install mimetypes
	cd "${WORKDIR}"/${M}
	mv README README.mimetypes
	dodoc README.mimetypes
	insinto /usr/share/endeavour2/
	doins mimetypes.ini
}
