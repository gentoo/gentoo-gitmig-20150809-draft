# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/pilot-link/pilot-link-0.11.3.ebuild,v 1.2 2003/09/06 22:21:40 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A suite of tools contains a series of conduits for moving
information to and from your Palm device and your desktop or workstation
system."

SRC_URI="http://pilot-link.org/source/${P}.tar.bz2"
HOMEPAGE="http://www.pilot-link.org/"
DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2 | LGPL-2"
KEYWORDS="x86 ppc sparc "

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
