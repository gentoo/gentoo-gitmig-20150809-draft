# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/sdcc/sdcc-2.5.0_p20060423.ebuild,v 1.1 2006/04/27 17:17:03 calchan Exp $

inherit eutils

MY_PV=${PV/*_p/}
DESCRIPTION="Small device C compiler (for various microprocessors)."
HOMEPAGE="http://sdcc.sourceforge.net/"
SRC_URI="http://sdcc.sourceforge.net/snapshots/sdcc-src/${PN}-src-${MY_PV}.tar.gz
	doc? ( http://sdcc.sourceforge.net/snapshots/docs/${PN}-doc-${MY_PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

DEPEND=">=dev-embedded/gputils-0.13.2
	dev-libs/boehm-gc"
RDEPEND="!dev-embedded/sdcc-cvs"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	find ./ -type f -exec sed -i s:PORTDIR:PORTINGDIR:g  {} \;
	find device/lib/pic*/ -type f -exec sed -i s:ARCH:SDCCARCH:g  {} \;
	find device/lib/pic/libdev/ -type f -exec sed -i s:CFLAGS:SDCCFLAGS:g  {} \;
}

src_compile() {
	econf --enable-libgc || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "Install failed"
	rm -rf ${D}/usr/share/${PN}/doc
	dodoc ChangeLog
	if use doc ; then
		cp -pPR ${WORKDIR}/doc/* ${D}/usr/share/doc/${PF}/
		find ${D}/usr/share/doc/${PF}/ -name *.txt -exec gzip -f -9 {} \;
	fi
}
