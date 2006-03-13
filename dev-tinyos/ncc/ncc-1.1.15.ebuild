# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tinyos/ncc/ncc-1.1.15.ebuild,v 1.2 2006/03/13 18:40:20 sanchan Exp $

CVS_MONTH="Dec"
CVS_YEAR="2005"
MY_P="tinyos"

DESCRIPTION="A TinyOS frontend for nesC compiler"
HOMEPAGE="http://www.tinyos.net/"
SRC_URI="http://www.tinyos.net/dist-1.1.0/tinyos/source/${MY_P}-${PV}${CVS_MONTH}${CVS_YEAR}cvs.tar.gz"
LICENSE="Intel"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=dev-lang/perl-5.8.5-r2
	>=sys-devel/autoconf-2.53
	>=sys-devel/automake-1.5
	>=dev-tinyos/nesc-1.2.1
	>=dev-tinyos/tos-1.1.15"

RDEPEND=">=dev-tinyos/nesc-1.2.1
	>=dev-tinyos/tos-1.1.15
	>=dev-lang/perl-5.8.5-r2"

IUSE=""

S=${WORKDIR}/${MY_P}-${PV}${CVS_MONTH}${CVS_YEAR}cvs/tools/src/ncc

src_compile() {
	./Bootstrap || die "Bootstrap failed"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
