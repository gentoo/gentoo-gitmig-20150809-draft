# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-20110928.ebuild,v 1.3 2011/10/15 20:25:01 hwoarang Exp $

EAPI="4"

inherit eutils emul-linux-x86

LICENSE="LGPL-2.1 GPL-3"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-medialibs-${PV}
	~app-emulation/emul-linux-x86-xlibs-${PV}"

src_install() {
	emul-linux-x86_src_install

	# Set LDPATH for not needing x11-libs/qt-core
	cat <<-EOF > "${T}/44qt4-emul"
	LDPATH=/usr/lib32/qt4
	EOF
	doenvd "${T}/44qt4-emul"
}
