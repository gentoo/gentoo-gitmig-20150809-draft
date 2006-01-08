# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vym/vym-1.7.0.ebuild,v 1.3 2006/01/08 13:06:56 genstef Exp $

inherit eutils qt3

DESCRIPTION="View Your Mind -- a mindmap tool"
HOMEPAGE="http://www.insilmaril.de/vym/"
SRC_URI="mirror://sourceforge/vym/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="$(qt_min_version 3.3.3)
	dev-lang/perl"
RDEPEND="${DEPEND}
	|| ( ( x11-libs/libX11
	x11-libs/libXext )
	virtual/x11 )"

src_unpack() {
	unpack ${A}

	cd ${S}

	epatch ${FILESDIR}/01_all_linkablemapobj-math.patch
	epatch ${FILESDIR}/02_all_misc-math.patch
}

src_compile() {
	${QTDIR}/bin/qmake -o Makefile vym.pro
	emake || die "emake failed"

	# we don't build the pdf, because texi2pdf chokes on the .tex source
	# atm
}

src_install() {
	dobin vym
	dobin scripts/exportvym
	dobin scripts/vym2html.sh
	dobin scripts/vym2txt.sh

	dodoc demos/liveform.vym
	dodoc demos/time-management.vym
	dodoc demos/todo.vym

	insinto /usr/share/${PN}/styles
	for x in `echo styles/*` ; do
		doins $x
	done

	insinto /usr/share/${PN}/styles/wiki
	for x in `echo styles/wiki/*` ; do
		doins $x
	done
}
