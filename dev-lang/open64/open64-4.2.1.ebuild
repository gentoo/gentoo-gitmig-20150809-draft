# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/open64/open64-4.2.1.ebuild,v 1.1 2009/04/28 13:11:03 patrick Exp $

EAPI="2"
SLOT="4.2.1"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"

IUSE=""
DESCRIPTION="The open64 compiler suite, based on Pathscale's EKO compiler"
HOMEPAGE="http://open64.net"

# we build the fortran bits unconditionally for now. Makefile does autodetection.
DEPEND="app-shells/tcsh
	=sys-devel/bison-2.3*
	<=sys-devel/gcc-4.2[fortran]"
RDEPEND=""

SRC_URI="mirror://sourceforge/${PN}/${P}-0.src.tar.bz2"
S=$WORKDIR/${P}-0

src_install() {
	export TOOLROOT="${D}"
	emake install || die
}
