# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mpack/mpack-1.6-r1.ebuild,v 1.1 2011/12/07 23:34:59 sping Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Command-line MIME encoding and decoding utilities"
HOMEPAGE="ftp://ftp.andrew.cmu.edu/pub/mpack/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/mpack/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~sparc ~x86 ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE=""

src_prepare() {
	# NOTE: These two patches replace <mpack-1.6-gentoo.patch>
	epatch "${FILESDIR}"/${P}-compile.patch
	epatch "${FILESDIR}"/${P}-paths.patch
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README.* Changes
}
