# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lshw/lshw-02.00b.ebuild,v 1.1 2004/12/20 15:44:26 matsuu Exp $

inherit flag-o-matic

MAJ_PV=${PV:0:5}
MIN_PVE=${PV:5:7}
MIN_PV=${MIN_PVE/b/B}

MY_P="$PN-$MIN_PV.$MAJ_PV"
DESCRIPTION="Hardware Lister"
HOMEPAGE="http://ezix.sourceforge.net/"
SRC_URI="mirror://sourceforge/ezix/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="gtk2"

DEPEND="virtual/libc
	gtk2? ( >=x11-libs/gtk+-2 )"

S=${WORKDIR}/${MY_P}

src_compile() {
	# cpuid.cc uses inline asm and can not be linked when
	# position independent code is desired.
	filter-flags -fPIC
	sed -i -e "/^CXXFLAGS/s/-Os/${CXXFLAGS}/" src/{gui/,core/,}/Makefile || die
	emake || die
	if use gtk2; then
		emake gui || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	if use gtk2; then
		make DESTDIR=${D} install-gui || die
	fi

	dodoc TODO docs/proc_usb_info.txt
}
