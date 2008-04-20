# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/recode/recode-3.6-r2.ebuild,v 1.22 2008/04/20 08:32:59 vapier Exp $

inherit eutils libtool toolchain-funcs

DEB_VER=11
DESCRIPTION="Convert files between various character sets"
HOMEPAGE="http://recode.progiciels-bpi.ca/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-debian-${DEB_VER}.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch #209036
	sed -i '1i#include <stdlib.h>' src/argmatch.c || die

	# Needed under FreeBSD, too
	epatch "${FILESDIR}"/${P}-ppc-macos.diff
	cp lib/error.c lib/xstrdup.c src/ || die "file copy failed"

	elibtoolize
}

src_compile() {
	tc-export CC LD
	# --without-included-gettext means we always use system headers
	# and library
	econf --without-included-gettext $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BACKLOG ChangeLog NEWS README THANKS TODO
	rm -f "${D}"/usr/lib/charset.alias
}
