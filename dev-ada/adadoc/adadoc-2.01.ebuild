# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/adadoc/adadoc-2.01.ebuild,v 1.5 2004/08/15 14:23:17 dholm Exp $

inherit eutils gnat

DESCRIPTION="A tool for Ada95 to create documentation from specification packages."

HOMEPAGE="http://adadoc.sourceforge.net"

SRC_URI="mirror://sourceforge/adadoc/${PN}-v${PV}.src.tar.bz2
	mirror://sourceforge/adadoc/UserGuide.pdf
	mirror://sourceforge/adadoc/HowToWriteModule.pdf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

IUSE=""

DEPEND="dev-lang/gnat
	>=dev-ada/xmlada-0.7.1-r2"

RDEPEND=""

S=${WORKDIR}/dev

src_unpack() {
	unpack ${PN}-v${PV}.src.tar.bz2
	cd ${S}
	epatch ${FILESDIR}/${P}-xmlada.patch || die "epatch failed"
}

src_compile() {
	${ADAMAKE} adadoc -cargs ${ADACFLAGS} -Itools -Iparser -Imodules `xmlada-config`
}

src_install() {
	dobin adadoc
	insinto /usr/share/doc/adadoc-${PV}
	doins ${DISTDIR}/UserGuide.pdf
	doins ${DISTDIR}/HowToWriteModule.pdf
	insinto /usr/share/adadoc
	doins adadoc_tags.cfg
}
