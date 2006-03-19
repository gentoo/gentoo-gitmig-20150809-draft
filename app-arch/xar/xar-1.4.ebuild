# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/xar/xar-1.4.ebuild,v 1.1 2006/03/19 18:56:00 kito Exp $

inherit eutils

DESCRIPTION="The XAR project aims to provide an easily extensible archive format."
HOMEPAGE="http://www.opendarwin.org/projects/xar/"
SRC_URI="http://www.opendarwin.org/projects/xar/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="debug"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	app-arch/bzip2
	dev-libs/openssl
	dev-libs/libxml2
	sys-libs/zlib"

src_compile() {
	# This is a var used by AMD64-multilib, unset this
	# or we'll have problems during econf/emake
	unset SYMLINK_LIB

	econf || die
	emake CFLAGS_OPTIMIZE="${CFLAGS}" LDFLAGS_OPTIMIZE="${LDFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
}
