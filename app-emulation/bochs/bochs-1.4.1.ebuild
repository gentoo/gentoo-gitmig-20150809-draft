# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/bochs/bochs-1.4.1.ebuild,v 1.12 2004/06/27 23:01:44 vapier Exp $

DESCRIPTION="a pc emulator"
HOMEPAGE="http://bochs.sourceforge.net/"
SRC_URI="mirror://sourceforge/bochs/${P}.tar.gz
	 http://bochs.sourceforge.net/guestos/dlxlinux3.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc ~alpha"
IUSE=""

DEPEND="virtual/libc
	virtual/x11"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	sed -i \
		-e "s:\$(WGET) \$(DLXLINUX_TAR_URL):cp ${DISTDIR}/dlxlinux3.tar.gz .:" \
		-e 's: $(prefix): $(DESTDIR)$(prefix):g' \
		-e 's: $(bindir): $(DESTDIR)$(bindir):g' \
		-e 's:BOCHSDIR=:BOCHSDIR=/usr/lib/bochs#:' \
		-e 's: $(BOCHSDIR): $(DESTDIR)$(BOCHSDIR):g' \
		Makefile.in
}

src_compile() {
	[ "$ARCH" == "x86" ] && myconf="--enable-idle-hack"

	./configure --enable-fpu --enable-cdrom --enable-control-panel \
	--enable-ne2000 --enable-sb16=linux --enable-slowdown --prefix=/usr \
	--infodir=/usr/share/info --mandir=/usr/share/man --host=${CHOST} --with-x11 $myconf || die

	# there's an sdl interface now, but since we an only compile 1 interface at a time
	# i'd rather have xwindows.

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc CHANGES CVS README TESTFORM.txt
}
