# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgii/libgii-0.8.1.ebuild,v 1.23 2006/04/09 18:02:13 vapier Exp $

inherit eutils

DESCRIPTION="Fast and safe graphics and drivers for about any graphics card to the Linux kernel (sometimes)"
HOMEPAGE="http://www.ggi-project.org/"
SRC_URI="http://www.ggi-project.org/ftp/ggi/v2.0/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="X"

RDEPEND="X? ( || ( x11-libs/libX11 virtual/x11 ) )"

src_compile() {
	local myconf

	use X || myconf="--without-x --disable-x --disable-xwin"

	epatch ${FILESDIR}/libgii-linux-headers-2.6.patch
	econf ${myconf} || die
	emake || die

}

src_install() {
	make DESTDIR=${D} install || die

	cd ${D}/usr/share/man/man3
	for i in *.3gii
	do
		mv ${i} ${i%.3gii}.3
	done

	cd ${S}
	dodoc ChangeLog* FAQ NEWS README
	docinto txt
	dodoc doc/*.txt
	docinto docbook
	dodoc doc/docbook/*.sgml
}
