# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pilot-link/pilot-link-0.11.1-r1.ebuild,v 1.4 2002/09/09 01:23:29 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A suite of tools contains a series of conduits for moving
information to and from your Palm device and your desktop or workstation
system."

SRC_URI="http://pilot-link.org/source/${P}.tar.bz2"
HOMEPAGE="http://www.pilot-link.org/"
DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2 | LGPL"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {

	local myconf

	use perl || myconf="${myconf} --with-perl5=no"
	use java || myconf="${myconf} --with-java=no"
	use tcltk || myconf="${myconf} --with-tcl=no --with-itcl=no --with-tk=no"

	econf \
		--includedir=/usr/include/libpisock \
		--with-perl5=no \
		--with-python=no \
		--with-java=no \
		--with-tcl=no \
		--with-itcl=no \
		--with-tk=no || die

	cd ${S}
	emake || die


}

src_install() {

	make \
		DESTDIR=${D} \
		install || die
		
	mv ${D}/*.hxx ${D}/usr/include/libpisock/

	dodoc ChangeLog README TODO NEWS AUTHORS

}
