# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libddmpeg/libddmpeg-1.5.ebuild,v 1.1 2004/02/06 14:10:41 max Exp $

inherit flag-o-matic

DESCRIPTION="VIA hardware MPEG decoder library."
HOMEPAGE="http://www.ivor.it/cle266"
SRC_URI="http://www.ivor.it/cle266/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 -*"

src_compile() {
	local cpu="`get-flag march || get-flag mcpu`"
	if [ -n "${cpu}" ] ; then
		sed -e "s:-march=i386:-march=${cpu}:" -i "Makefile" || die "sed failed"
	fi

	emake || die "compile problem"
}

src_install() {
	dolib.so libddmpeg.so
}

pkg_postinst() {
	echo
	ewarn "This library won't work without a compatible kernel module."
	einfo "Get the appropriate kernel patches from here:"
	einfo "  http://epia.kalf.org/epia_kernel/"
	einfo "The Gentoo/cle266 HOWTO is available here:"
	einfo "  http://www.alterself.com/~epia/"
	echo
}
