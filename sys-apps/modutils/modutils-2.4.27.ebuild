# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.27.ebuild,v 1.7 2005/03/28 21:40:13 hansmi Exp $

inherit eutils

DESCRIPTION="Standard kernel module utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/modutils/"
SRC_URI="mirror://kernel/linux/utils/kernel/${PN}/v2.4/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha -amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="virtual/libc
	!virtual/modutils"
PROVIDE="virtual/modutils"

src_unpack() {
	unpack ${A}

	EPATCH_OPTS="-d ${S}/util" \
	epatch ${FILESDIR}/alias.h.diff
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc34.patch
}

src_compile() {
	econf \
		--prefix=/ \
		--disable-strip \
		--enable-insmod-static \
		--disable-zlib \
		|| die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall prefix="${D}" || die "make install failed"
	dodoc CREDITS ChangeLog NEWS README TODO
}
