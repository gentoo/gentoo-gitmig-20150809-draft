# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/adadoc/adadoc-2.01.ebuild,v 1.1 2003/08/14 01:57:09 dholm Exp $

inherit gnat

DESCRIPTION="A tool for Ada95 to create documentation from specification packages."

HOMEPAGE="http://adadoc.sourceforge.net"

SRC_URI="mirror://sourceforge/adadoc/${PN}-v${PV}.src.tar.bz2
	mirror://sourceforge/adadoc/UserGuide.pdf
	mirror://sourceforge/adadoc/HowToWriteModule.pdf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="dev-lang/gnat
	>=dev-ada/xmlada-0.7.1-r2"

RDEPEND=""

S=${WORKDIR}/dev

src_unpack() {
	unpack ${PN}-v${PV}.src.tar.bz2
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
