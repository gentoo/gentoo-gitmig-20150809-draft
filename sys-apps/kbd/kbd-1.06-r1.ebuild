# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-1.06-r1.ebuild,v 1.7 2002/09/14 15:51:25 bjb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Keyboard and console utilities"
SRC_URI="ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/kbd/${P}.tar.gz"
HOMEPAGE=""
KEYWORDS="x86 ppc sparc sparc64 alpha"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
PROVIDE="sys-apps/console-tools"

src_compile() {
	local myopts
	# non-standard configure script; --di to disable NLS, nothing to enable it.	
	use nls || myopts="--di"
	./configure --mandir=/usr/share/man \
	--datadir=/usr/share \
	${myopts} || die
	make || die
}

src_install() {
	make  \
	DESTDIR=${D} \
	DATADIR=${D}/usr/share \
	MANDIR=${D}/usr/share/man \
	install || die
}
