# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-backends/sane-backends-1.0.13-r3.ebuild,v 1.6 2004/11/24 22:43:34 centic Exp $

inherit eutils

IUSE="usb"

DESCRIPTION="Scanner Access Now Easy - Backends"
HOMEPAGE="http://www.sane-project.org/"

DEPEND=">=media-libs/jpeg-6b
	x86? ( sys-libs/libieee1284 )
	=sys-apps/sed-4*
	usb? ( dev-libs/libusb )"

BROTHERMFCDRIVER="sane-backends-1.0.13-brothermfc-r1.patch"

SRC_URI="ftp://ftp.mostang.com/pub/sane/${P}/${P}.tar.gz
	ftp://ftp.mostang.com/pub/sane/old-versions/${P}/${P}.tar.gz
	usb? ( mirror://gentoo/${BROTHERMFCDRIVER}.bz2 )"
SLOT="0"
LICENSE="GPL-2 public-domain"
KEYWORDS="x86 ppc sparc alpha amd64 ia64"


src_unpack() {
	unpack ${A}
	use usb && unpack ${BROTHERMFCDRIVER}.bz2
	cp ${FILESDIR}/linux_sg3_err.h ${S}/sanei

	cd ${S}

	#only generate the .ps and not the fonts
	sed -i -e 's:$(DVIPS) sane.dvi -o sane.ps:$(DVIPS) sane.dvi -M1 -o sane.ps:' \
		doc/Makefile.in
	#compile errors when using NDEBUG otherwise
	sed -i -e 's:function_name:__FUNCTION__:g' backend/artec_eplus48u.c
	use usb && epatch ${WORKDIR}/${BROTHERMFCDRIVER}
}

src_compile() {
	local myconf
	myconf="$(use_enable usb libusb)"
	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--host=${CHOST} ${myconf} || die
	make || die
}

src_install () {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc/${PF} \
		install || die

	docinto backend
	cd backend
	dodoc GUIDE *.README *.BUGS *.CHANGES *.FAQ *.TODO

	echo "SANE_CONFIG_DIR=/etc/sane.d" > 30sane
	insinto /etc/env.d
	doins 30sane

}
