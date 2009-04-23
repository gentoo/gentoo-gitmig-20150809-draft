# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc-ide/fpc-ide-2.2.4.ebuild,v 1.1 2009/04/23 21:05:02 truedfx Exp $

S="${WORKDIR}/fpcbuild-${PV}/fpcsrc/ide"

HOMEPAGE="http://www.freepascal.org/"
DESCRIPTION="Free Pascal Compiler Integrated Development Environment"
SRC_URI="mirror://sourceforge/freepascal/fpcbuild-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="~dev-lang/fpc-${PV}"

src_unpack() {
	unpack ${A} || die "Unpacking ${A} failed!"

	find "${WORKDIR}" -name Makefile -exec sed -i -e 's/ -Xs / /g' {} + || die
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake -j1 INSTALL_PREFIX="${D}"usr install || die "make install failed"
}
