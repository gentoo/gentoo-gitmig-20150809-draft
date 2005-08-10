# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/pwmanager/pwmanager-1.2.3.ebuild,v 1.3 2005/08/10 13:40:34 blubb Exp $

inherit kde

DESCRIPTION="Password manager for KDE supporting chipcard access and encryption."
HOMEPAGE="http://passwordmanager.sourceforge.net"
SRC_URI="mirror://sourceforge/passwordmanager/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="smartcard"

DEPEND="smartcard? ( sys-libs/libchipcard )
	sys-libs/zlib
	app-arch/bzip2"

need-kde 3.3

src_compile() {
	local myconf="--enable-kwallet"

	if use smartcard; then
		myconf="${myconf} --enable-pwmanager-smartcard"

		if has_version "=sys-libs/libchipcard-0.9*"; then
			myconf="${myconf} --enable-pwmanager-libchipcard1"
		else
			myconf="${myconf} --disable-pwmanager-libchipcard1"
		fi

		if has_version ">=sys-libs/libchipcard-1.9"; then
			myconf="${myconf} --enable-pwmanager-libchipcard2"
		else
			myconf="${myconf} --disable-pwmanager-libchipcard2"
		fi
	else
		myconf="${myconf} --disable-pwmanager-smartcard"
	fi

	kde_src_compile
}
