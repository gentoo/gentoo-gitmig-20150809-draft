# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fvwm-crystal-apps/fvwm-crystal-apps-0.5.ebuild,v 1.5 2004/09/18 19:13:56 weeve Exp $

MY_P="${P/fvwm-crystal-//}"
DESCRIPTION="Simple tool that builds FVWM-Crystal Application Panel from a database"
HOMEPAGE="http://fvwm-crystal.linux.net.pl/"
SRC_URI="http://fvwm-crystal.linux.net.pl/files/files/apps/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""
DEPEND="sys-devel/make"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	sed -i -e "s/g++/g++ ${CXXFLAGS}/" ${S}/Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin apps
	dodoc AUTHORS COPYING database INSTALL NEWS README
}

