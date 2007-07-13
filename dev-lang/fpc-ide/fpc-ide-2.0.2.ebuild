# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc-ide/fpc-ide-2.0.2.ebuild,v 1.2 2007/07/13 06:25:50 mr_bones_ Exp $

S="${WORKDIR}/fpc"

DESCRIPTION="Free Pascal Compiler Integrated Development Environment"
HOMEPAGE="http://www.freepascal.org/"
SRC_URI="mirror://sourceforge/freepascal/fpc-${PV}.source.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="~dev-lang/fpc-2.0.2
	sys-libs/gpm"

src_compile () {
	make -j1 -C ide all || die "make ide failed!"
}

src_install () {
	make ide_install INSTALL_PREFIX=${D}usr || die "make ide_install failed!"
}
