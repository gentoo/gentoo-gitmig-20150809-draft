# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/bochs/bochs-2.0.2.ebuild,v 1.9 2003/12/24 19:03:46 bazik Exp $

inherit eutils

DESCRIPTION="a LGPL-ed pc emulator"
HOMEPAGE="http://bochs.sourceforge.net/"
SRC_URI="mirror://sourceforge/bochs/${P}.tar.gz
	 http://bochs.sourceforge.net/guestos/dlxlinux3.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc"
IUSE="sdl gtk"

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.1
	>=sys-apps/sed-4
	sdl? media-libs/libsdl
	gtk?  x11-libs/wxGTK"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	sed -i \
		-e "s:\$(WGET) \$(DLXLINUX_TAR_URL):cp ${DISTDIR}/dlxlinux3.tar.gz .:" \
		-e 's:BOCHSDIR=:BOCHSDIR=/usr/lib/bochs#:' \
		-e 's: $(BOCHSDIR): $(DESTDIR)$(BOCHSDIR):g' Makefile.in || \
			die "sed Makefile.in failed"
	epatch ${FILESDIR}/${P}-gcc3.patch || die
}

src_compile() {
	[ "$ARCH" == "x86" ] && myconf="--enable-idle-hack"
	myconf="${myconf} `use_with sdl`"
	myconf="${myconf} `use_with gtk wx`"

	./configure \
		--enable-fpu --enable-cdrom --enable-control-panel \
		--enable-ne2000 --enable-sb16=linux --enable-slowdown --prefix=/usr \
		--infodir=/usr/share/info --mandir=/usr/share/man --host=${CHOST} \
		--with-x11 $myconf || \
			die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc CHANGES CVS README TESTFORM.txt || die "dodoc failed"
}
