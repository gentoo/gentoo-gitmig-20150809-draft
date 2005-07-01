# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vym/vym-1.5.0.ebuild,v 1.3 2005/07/01 15:14:10 caleb Exp $

inherit eutils

DESCRIPTION="View Your Mind -- a mindmap tool"
HOMEPAGE="http://www.insilmaril.de/vym/"
SRC_URI="${HOMEPAGE}/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="
	>=dev-libs/expat-1.95.8 \
	>=media-libs/fontconfig-2.2.3 \
	>=media-libs/freetype-2.1.5-r1 \
	>=media-libs/jpeg-6b-r4 \
	>=media-libs/libmng-1.0.4 \
	>=media-libs/libpng-1.2.7 \
	>=sys-devel/gcc-3.3.4-r1 \
	>=sys-libs/glibc-2.3.4.20040808-r1 \
	>=sys-libs/zlib-1.2.1-r3 \
	>=x11-base/xorg-x11-6.8.0-r3 \
	>=x11-libs/qt-3.3.3 \
	dev-lang/perl"
#RDEPEND=""
#S=${WORKDIR}/${P}

src_compile() {
	cd ${S}
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
