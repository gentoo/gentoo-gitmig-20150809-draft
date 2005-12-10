# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-glibc/emul-linux-x86-glibc-1000.ebuild,v 1.2 2005/12/10 19:07:01 blubb Exp $

DESCRIPTION="GNU C Library for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="virtual/libc"

pkg_postinst() {
	einfo "32bit libc is now provided by sys-libs/glibc."
}
