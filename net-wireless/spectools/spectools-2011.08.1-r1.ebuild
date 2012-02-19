# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/spectools/spectools-2011.08.1-r1.ebuild,v 1.1 2012/02/19 22:27:11 robbat2 Exp $

EAPI=4

inherit toolchain-funcs eutils

MY_PN=${PN}
MY_PV=${PV/\./-}
MY_PV=${MY_PV/./-R}
MY_P="${MY_PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="IEEE 802.11 wireless LAN sniffer for MetaGeek Wi-Spy spectrum analyzer hardware"
HOMEPAGE="http://www.kismetwireless.net/spectools/"

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="https://www.kismetwireless.net/code/svn/tools/spectools"
		inherit subversion
		KEYWORDS=""
else
		SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"
		KEYWORDS="~amd64 ~arm ~ppc ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="ncurses gtk"

DEPEND="${RDEPEND}"
RDEPEND="virtual/libusb:0
	ncurses? ( sys-libs/ncurses )
	gtk? ( =x11-libs/gtk+-2* )"
# Upstream has still not migrated to the libusb-1 line.
# Maemo: Add hildon and bbus

# Please note that upstream removed the --with-gtk-version option
# and GTK is now automagical. GTK1 support was also removed.
src_compile() {
	emake depend

	emake spectool_net spectool_raw

	if use ncurses; then
		emake spectool_curses
	fi

	if use gtk; then
		emake spectool_gtk
	fi

	#if use maemo; then
	#	emake spectool_hildon usbcontrol \
	#		|| die "emake spectool_hildon usbcontrol failed"
	#fi
}

src_install() {
	dobin spectool_net spectool_raw
	use ncurses && dobin spectool_curses
	use gtk && dobin spectool_gtk

	dodir /$(get_libdir)/udev/rules.d/
	insinto /$(get_libdir)/udev/rules.d/
	doins 99-wispy.rules
	dodoc README

	#if use maemo; then
	#	dobin spectool_hildon
	#	dosbin usbcontrol
	#fi
}
