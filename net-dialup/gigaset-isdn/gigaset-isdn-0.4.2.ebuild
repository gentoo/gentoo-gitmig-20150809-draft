# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gigaset-isdn/gigaset-isdn-0.4.2.ebuild,v 1.1 2005/04/14 20:09:13 mrness Exp $

inherit linux-mod

MY_P=${P/-isdn/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Kernel driver for Gigaset 307X/M105/M101 and compatible ISDN adapters."
HOMEPAGE="http://gigaset307x.sourceforge.net/"
SRC_URI="mirror://sourceforge/gigaset307x/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="virtual/linux-sources"

MODULE_NAMES="bas_gigaset(drivers/isdn:) ser_gigaset(drivers/isdn:) usb_gigaset(drivers/isdn:)"
BUILD_TARGETS="all"
CONFIG_CHECK="ISDN_I4L"
ISDN_I4L_ERROR="This driver requires that your kernel is compiled with support for ISDN4Linux (I4L)"

src_unpack() {
	unpack ${A}

	# Fix broken makefile
	convert_to_m ${S}/Makefile.26.in

	# We will take care of installing modules, not you
	sed -i "s:if \[ \$\# -ne 0 \]:if \[ 0 -ne 0 \]:g" ${S}/generic/installfiles

	# We will run depmod, not you
	sed -i "s:.*generic/post.*::g" ${S}/generic/install
}

src_compile() {
	./configure --kernel=${KV_FULL} --kerneldir=${KV_DIR} --root=${D} --prefix=/usr \
		--with-ring $(use_with debug)

	linux-mod_src_compile
}

src_install () {
	linux-mod_src_install
	einstall ROOT=${D} || die "Failed to install frontend"
	dodoc README Release.notes TODO known_bugs.txt
}
