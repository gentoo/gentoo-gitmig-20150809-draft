# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-backends/sane-backends-1.0.12-r1.ebuild,v 1.4 2003/09/11 01:18:39 msterret Exp $

IUSE=""

DESCRIPTION="Scanner Access Now Easy - Backends"
HOMEPAGE="http://www.mostang.com/sane/"

DEPEND=">=media-libs/jpeg-6b
	x86? ( sys-libs/libieee1284 )
	=sys-apps/sed-4*"

PLUSTEK_VER="0.46-TEST1"

SRC_URI="ftp://ftp.mostang.com/pub/sane/${P}/${P}.tar.gz
	ftp://ftp.mostang.com/pub/sane/old-versions/${P}/${P}.tar.gz
	http://www.gjaeger.de/scanner/test/plustek-${PLUSTEK_VER}.tar.gz"
S=${WORKDIR}/${P}
SLOT="0"
LICENSE="GPL-2 public-domain"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"


src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/linux_sg3_err.h ${S}/sanei

	# Update the Plustek driver
	# the plustek driver 1.1.27t needs to be unpacked inside the
	# sane-backends directory.

	ebegin "Updating Plustek driver"
	cd ${S}
	# the plustek.desc file shipped with the driver does not compile,
	# this workaround uses the old file from the pristine source instead.
	cp doc/descriptions/plustek.desc .
	unpack plustek-${PLUSTEK_VER}.tar.gz
	cp plustek.desc doc/descriptions/
	cd ${WORKDIR}
	eend 0

	#only generate the .ps and not the fonts
	sed -i -e 's:$(DVIPS) sane.dvi -o sane.ps:$(DVIPS) sane.dvi -M1 -o sane.ps:' \
		${S}/doc/Makefile.in
}

src_compile() {
	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--host=${CHOST} || die
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
