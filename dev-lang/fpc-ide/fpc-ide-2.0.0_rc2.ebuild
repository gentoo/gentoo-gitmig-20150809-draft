# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc-ide/fpc-ide-2.0.0_rc2.ebuild,v 1.1 2005/03/31 01:58:21 chriswhite Exp $

MY_P="1.9.8"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~x86"
DESCRIPTION="Free Pascal Compiler Integrated Development Environment"
HOMEPAGE="http://www.freepascal.org/"
IUSE=""
SRC_URI="ftp://ftp.freepascal.org/pub/fpc/beta/source-${MY_P}/fpc-${MY_P}.source.tar.gz"
DEPEND=">=dev-lang/fpc-2.0.0_rc2
	  sys-libs/gpm"
RDEPEND=">=dev-lang/fpc-2.0.0_rc2
	   sys-libs/gpm"

S=${WORKDIR}/fpc

src_unpack () {
	unpack ${A} || die "Unpacking ${A} failed!"
}

src_compile () {
	# "make ide" wouldn't read default config, so we compile from subdir.
	emake -j1 \
	-C ide \
	all \
	|| die "make ide failed!"
}

src_install () {
	emake -j1 \
		ide_install \
	INSTALL_PREFIX=${D}usr \
	|| die "make ide_install failed!"
}
