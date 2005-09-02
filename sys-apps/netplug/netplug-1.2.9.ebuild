# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netplug/netplug-1.2.9.ebuild,v 1.1 2005/09/02 11:11:20 uberlord Exp $

inherit eutils
DESCRIPTION="Brings up/down ethernet ports automatically with cable detection"
HOMEPAGE="http://www.red-bean.com/~bos/"
SRC_URI="http://www.red-bean.com/~bos/netplug/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

	# Use correct structure for getsockname arg 3
	epatch "${FILESDIR}/netplug-1.2.9-gcc4.patch"
}

src_compile() {
	hax_bitkeeper
	emake || die "emake failed"
}

src_install() {
	into /
	dosbin netplugd
	doman man/man8/netplugd.8

	dodir /etc/netplug.d
	exeinto /etc/netplug.d
	doexe "${FILESDIR}/netplug"
}
