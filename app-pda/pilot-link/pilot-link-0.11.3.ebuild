# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/pilot-link/pilot-link-0.11.3.ebuild,v 1.10 2004/11/07 09:23:36 mr_bones_ Exp $

DESCRIPTION="A suite of tools contains a series of conduits for moving
information to and from your Palm device and your desktop or workstation
system."

SRC_URI="http://pilot-link.org/source/${P}.tar.bz2"
HOMEPAGE="http://www.pilot-link.org/"
DEPEND="virtual/libc"

LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="java perl tcltk"

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
