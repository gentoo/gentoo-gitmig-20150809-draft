# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libddmpeg/libddmpeg-1.6.ebuild,v 1.5 2004/07/14 20:01:29 agriffis Exp $

inherit flag-o-matic

DESCRIPTION="VIA hardware MPEG decoder library."
HOMEPAGE="http://www.ivor.it/cle266"
SRC_URI="http://www.ivor.it/cle266/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64 -*"
IUSE=""

src_compile() {
	local cpu="`get-flag march`"
	if [ -n "${cpu}" ] ; then
		sed -e "s:-march=i386:-march=${cpu}:" -i "Makefile" || die "sed failed"
	fi
	# We don't want -march=i386 but we do want -fPIC. Quick swap...
	# - avenj@gentoo.org (8 Mar 04)
	if use amd64; then
		sed -e "s:-march=i386:-fPIC:" -i "Makefile" || die "sed failed"
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
