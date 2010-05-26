# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/barry/barry-0.16.ebuild,v 1.6 2010/05/26 08:53:27 bangert Exp $

inherit autotools base

DESCRIPTION="Allow synchronization, backup, restore,
program management, and charging for BlackBerry devices"
HOMEPAGE="http://www.netdirect.ca/software/packages/barry/"
SRC_URI="mirror://sourceforge/barry/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boost doc gui opensync"

DEPEND="dev-libs/libusb
	dev-libs/openssl
	dev-util/pkgconfig
	sys-libs/zlib
	boost? 	( >=dev-libs/boost-1.33  )
	doc?	( >=app-doc/doxygen-1.5.6 )
	gui? 	( >=dev-cpp/gtkmm-2.4
				>=dev-cpp/libglademm-2.4
				>=dev-cpp/glibmm-2.4
				>=dev-libs/libtar-1.2.11-r2 )
	opensync? ( =app-pda/libopensync-0.22* )"
RDEPEND="dev-libs/libusb
	sys-libs/zlib
	boost?  ( >=dev-libs/boost-1.33  )
	gui?    ( >=dev-cpp/gtkmm-2.4
				>=dev-cpp/libglademm-2.4
				>=dev-cpp/glibmm-2.4 )
	opensync? ( =app-pda/libopensync-0.22* )"

PATCHES=(
	"${FILESDIR}/${P}-gcc45.patch"
	"${FILESDIR}/${P}-asneeded.patch"
	)

src_unpack(){
	base_src_unpack
	cd "${S}"
	eautoreconf
}

src_compile(){
	econf \
		$(use_enable boost) \
		$(use_enable gui) \
		$(use_with gui libtar /usr) \
		$(use_with gui libz) \
		$(use_enable opensync opensync-plugin)

	emake || die

	if use doc ; then
		cd "${S}"
		doxygen
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	if use doc; then
		dodoc AUTHORS NEWS README || die
		dohtml doc/www/doxygen/html/*  || die
	fi

	#  udev rules
	insinto /etc/udev/rules.d
	newins "${FILESDIR}"/10-blackberry.rules 10-blackberry.rules

	#  blacklist for BERRY_CHARGE kernel module
	insinto /etc/modprobe.d
	newins "${FILESDIR}"/blacklist-berry_charge.conf blacklist-berry_charge.conf

	#if use gui ; then
		# Add an entry into K Menu or gnome's menu if available.
	#fi
}

pkg_postinst() {
	elog
	elog "Users must be in the 'plugdev' group to access the Barry toolset."
	elog
	elog "Type 'btool' to launch the command-line Barry interface."
	use gui && elog "Type 'barrybackup' to launch the GUI backup/restore tool."
	ewarn
	ewarn "Barry and the in-kernel module 'BERRY_CHARGE' are incompatible."
	ewarn
	ewarn "Kernel-based USB suspending can discharge your blackberry."
	ewarn "Use at least kernel 2.6.22 and/or disable USB_SUSPEND."
	ewarn
}
