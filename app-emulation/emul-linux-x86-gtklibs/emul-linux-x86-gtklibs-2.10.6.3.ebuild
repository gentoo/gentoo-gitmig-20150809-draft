# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-gtklibs/emul-linux-x86-gtklibs-2.10.6.3.ebuild,v 1.2 2006/12/07 04:03:31 tester Exp $

DESCRIPTION="Gtk+ 1/2 for emulation of 32bit x86 on amd64"
SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://dev.gentoo.org/~tester/dist/emul/${P}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE="qt3"

QA_EXECSTACK_amd64="emul/linux/x86/usr/lib/libgdk_pixbuf.so.2.0.0
	emul/linux/x86/usr/lib/libgdk_pixbuf_xlib.so.2.0.0"

S="${WORKDIR}"

RDEPEND=">=app-emulation/emul-linux-x86-xlibs-7.0-r3
	>=app-emulation/emul-linux-x86-baselibs-2.5.3
	x11-libs/pango
	>=x11-libs/gtk+-2.10
	>=x11-themes/gtk-engines-2.8
	qt3? ( >=app-emulation/emul-linux-x86-qtlibs-3.4.4 )"

RESTRICT="nostrip"

src_install() {
	# Avoid dep on qtlibs if qt support not required
	use !qt3 && rm -f "${WORKDIR}/emul/linux/x86/usr/lib/gtk-2.0/2.10.0/engines/libqtengine.so"

	cp -RPvf ${WORKDIR}/* ${D}/
	doenvd ${FILESDIR}/50emul-linux-x86-gtklibs
}
