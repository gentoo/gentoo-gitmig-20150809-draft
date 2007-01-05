# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-gtklibs/emul-linux-x86-gtklibs-2.10.6.3-r3.ebuild,v 1.1 2007/01/05 10:25:38 vapier Exp $

inherit eutils

DESCRIPTION="Gtk+ 1/2 for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~tester/dist/emul/${P}.tar.bz2
	mirror://gentoo/${P}-r2-emul.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="qt3"
RESTRICT="nostrip"

DEPEND="app-admin/chrpath"
RDEPEND=">=app-emulation/emul-linux-x86-xlibs-7.0-r7
	>=app-emulation/emul-linux-x86-baselibs-2.5.5-r2
	x11-libs/pango
	>=x11-libs/gtk+-2.10
	>=x11-themes/gtk-engines-2.8
	qt3? ( >=app-emulation/emul-linux-x86-qtlibs-3.4.4-r3 )"

S=${WORKDIR}

QA_EXECSTACK_amd64="usr/lib32/libgdk_pixbuf.so.2.0.0
	usr/lib32/libgdk_pixbuf_xlib.so.2.0.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir usr
	mv emul/linux/x86/usr/lib usr/lib32 || die
	rmdir emul/linux/x86/usr emul/linux/x86 emul/linux emul || die
	use !qt3 && rm usr/lib32/gtk-2.0/2.10.0/engines/libqtengine.so
	cp -a ${WORKDIR}{,.old}
	sed -i \
		-e 's:/emul/linux/x86/usr/lib/:/usr/lib32/:g' \
		etc/*/i686-pc-linux-gnu/* || die
	epatch ${P}-r2-emul.patch
	rm ${P}-r2-emul.patch || die
}

src_install() {
	cp -a "${WORKDIR}"/* "${D}"/ || die
}
