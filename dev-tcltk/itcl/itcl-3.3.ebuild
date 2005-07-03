# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/itcl/itcl-3.3.ebuild,v 1.1 2005/07/03 02:46:24 matsuu Exp $

inherit eutils

MY_P=${PN}${PV}
DESCRIPTION="Object Oriented Enhancements for Tcl/Tk"
HOMEPAGE="http://incrtcl.sourceforge.net/"
SRC_URI="mirror://sourceforge/incrtcl/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

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
