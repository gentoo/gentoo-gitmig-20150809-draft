# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcfclock/pcfclock-0.44-r1.ebuild,v 1.2 2006/01/11 00:54:47 sbriesen Exp $

inherit eutils linux-mod

DESCRIPTION="driver for the parallel port radio clock sold by Conrad Electronic"
HOMEPAGE="http://www-stud.ims.uni-stuttgart.de/~voegelas/pcf.html"
SRC_URI="http://www-stud.ims.uni-stuttgart.de/~voegelas/pcfclock/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/linux-sources"

pkg_setup() {
	CONFIG_CHECK="PARPORT"
	linux-mod_pkg_setup
	BUILD_TARGETS="all"
	ECONF_PARAMS="--with-linux=${KERNEL_DIR}"
	MODULE_NAMES="pcfclock(::${S}/linux)"
	MODULESD_PCFCLOCK_ENABLED="yes"
	MODULESD_PCFCLOCK_EXAMPLES=( "pcfclock parport=0,none,none" )
	MODULESD_PCFCLOCK_ALIASES=(
		"char-major-181 pcfclock"
		"/dev/pcfclock0 char-major-181"
		"/dev/pcfclock1 char-major-181"
		"/dev/pcfclock2 char-major-181"
	)
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-udev.patch"
	convert_to_m "linux/Makefile.in"
}

src_install() {
	linux-mod_src_install
	dosbin pcfdate/pcfdate
	doman {linux,pcfdate}/*.[48]
	dodoc AUTHORS ChangeLog NEWS README THANKS

	# Add configuration for udev
	if [ -e ${ROOT}dev/.udev ]; then
		dodir /etc/udev/rules.d
		echo 'KERNEL=="pcfclock*", NAME="%k", MODE="0444"' \
			> "${D}/etc/udev/rules.d/55-${PN}.rules"
	fi
}
