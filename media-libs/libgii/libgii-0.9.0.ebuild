# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgii/libgii-0.9.0.ebuild,v 1.3 2005/03/30 07:53:37 chriswhite Exp $

inherit eutils

DESCRIPTION="Fast and safe graphics and drivers for about any graphics card to the Linux kernel (sometimes)"
HOMEPAGE="http://www.ggi-project.org/"
SRC_URI="http://www.ggi-project.org/ftp/ggi/v2.1/${P}.src.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="X"

DEPEND="X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-linux26-headers.patch
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	local myconf

	use X || myconf="--without-x --disable-x --disable-xwin"

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
