# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/itcl/itcl-3.3.ebuild,v 1.5 2006/01/16 01:29:56 weeve Exp $

inherit eutils

MY_P=${PN}${PV}
DESCRIPTION="Object Oriented Enhancements for Tcl/Tk"
HOMEPAGE="http://incrtcl.sourceforge.net/"
SRC_URI="mirror://sourceforge/incrtcl/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha amd64 ppc sparc x86"

DEPEND="dev-lang/tcl"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die "econf failed"
	emake CFLAGS_DEFAULT="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc CHANGES ChangeLog INCOMPATIBLE README TODO
}
