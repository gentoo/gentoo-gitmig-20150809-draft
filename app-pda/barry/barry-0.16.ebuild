# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/barry/barry-0.16.ebuild,v 1.12 2012/05/03 20:20:56 jdhore Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Sync, backup, program management, and charging for BlackBerry devices"
HOMEPAGE="http://www.netdirect.ca/software/packages/barry/"
SRC_URI="mirror://sourceforge/barry/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boost doc gui"

RDEPEND="dev-libs/libusb:0
	dev-libs/openssl
	sys-libs/zlib
	boost?	( >=dev-libs/boost-1.33 )
	gui?	( >=dev-cpp/gtkmm-2.4:2.4
			  >=dev-cpp/libglademm-2.4:2.4
			  >=dev-cpp/glibmm-2.4:2
			  >=dev-libs/libtar-1.2.11-r2 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc?	( >=app-doc/doxygen-1.5.6 )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc45.patch
	sed -i -e '/bdptest_LDADD =/ s:\(.*\):\1 ../src/libbarry.la:' tools/Makefile.in
	# Think twice about running eautoreconf here.  Upstream seems to like
	# patching the generated files directly and the sources don't remotely
	# match anymore.  See bug #319795.
}

src_configure() {
	econf \
		$(use_enable boost) \
		$(use_enable gui) \
		$(use_with gui libtar /usr) \
		$(use_with gui libz) \
		--disable-opensync-plugin
}

src_compile() {
	emake || die "emake failed"

	if use doc ; then
		cd "${S}"
		doxygen
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README || die

	if use doc; then
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
