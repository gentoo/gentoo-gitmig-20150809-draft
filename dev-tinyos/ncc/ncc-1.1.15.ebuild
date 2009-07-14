# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tinyos/ncc/ncc-1.1.15.ebuild,v 1.4 2009/07/14 20:42:33 fauli Exp $

CVS_MONTH="Dec"
CVS_YEAR="2005"
MY_P="tinyos"

DESCRIPTION="A TinyOS frontend for nesC compiler"
HOMEPAGE="http://www.tinyos.net/"
SRC_URI="http://www.tinyos.net/dist-1.1.0/tinyos/source/${MY_P}-${PV}${CVS_MONTH}${CVS_YEAR}cvs.tar.gz"
LICENSE="Intel"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=dev-tinyos/tos-1.1.15
	>=dev-lang/perl-5.8.5-r2
	>=dev-tinyos/nesc-1.2.1
	!dev-lang/nemerle"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.53
	>=sys-devel/automake-1.5"

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
