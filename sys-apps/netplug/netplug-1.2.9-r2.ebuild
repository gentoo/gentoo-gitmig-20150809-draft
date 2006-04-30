# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netplug/netplug-1.2.9-r2.ebuild,v 1.4 2006/04/30 13:26:23 blubb Exp $

inherit eutils
DESCRIPTION="Brings up/down ethernet ports automatically with cable detection"
HOMEPAGE="http://www.red-bean.com/~bos/"
SRC_URI="http://www.red-bean.com/~bos/netplug/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

hax_bitkeeper() {
	# the makefiles have support for bk ...
	# basically we have to do this or bk will try to write
	# to files in /opt/bitkeeper causing sandbox violations ;(
	mkdir "${T}/fakebin"
	echo "#!/bin/sh"$'\n'"exit 1" > "${T}/fakebin/bk"
	chmod a+x "${T}/fakebin/bk"
	export PATH="${T}/fakebin:${PATH}"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Remove debugging from Makefile
	# Remove -O3 if we have -O[0-9] in our CFLAGS
	local remove=" -ggdb3 "
	[[ " ${CFLAGS} " == *" -O"[0-9]" "* ]] && remove="${remove}-O3 "
	sed -i -e "s/${remove}/ /" Makefile

	# Use correct structure for getsockname arg 3
	epatch "${FILESDIR}/${P}-gcc4.patch"

	# Remove nested functions, #116140
	epatch "${FILESDIR}/${P}-remove-nest.patch"
}

src_compile() {
	hax_bitkeeper
	make || die "emake failed"
}

src_install() {
	into /
	dosbin netplugd
	doman man/man8/netplugd.8

	dodir /etc/netplug.d
	exeinto /etc/netplug.d
	doexe "${FILESDIR}/netplug"

	dodir /etc/netplug
	echo "eth*" > "${D}"/etc/netplug/netplugd.conf
}
