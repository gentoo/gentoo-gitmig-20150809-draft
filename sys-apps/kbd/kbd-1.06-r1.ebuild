# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-1.06-r1.ebuild,v 1.20 2003/05/20 21:06:44 kumba Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Keyboard and console utilities"
SRC_URI="ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/kbd/${P}.tar.gz"
HOMEPAGE="http://freshmeat.net/projects/kbd/"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
PROVIDE="sys-apps/console-tools"

src_compile() {
	local myopts

	# fixes makefile so that it uses the CFLAGS from portage. Fixes  bug #21320
	cp src/Makefile.in src/Makefile.in.orig
	sed -e "s:-O2:${CFLAGS}:g" src/Makefile.in.orig > src/Makefile.in
	 

	# non-standard configure script; --di to disable NLS, nothing to enable it.	
	use nls || myopts="--di"
	./configure --mandir=/usr/share/man \
		--datadir=/usr/share \
		${myopts} || die
	make || die
}

src_install() {
	make \
		DESTDIR=${D} \
		DATADIR=${D}/usr/share \
		MANDIR=${D}/usr/share/man \
		install || die
}
