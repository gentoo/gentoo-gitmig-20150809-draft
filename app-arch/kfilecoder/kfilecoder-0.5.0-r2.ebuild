# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/kfilecoder/kfilecoder-0.5.0-r2.ebuild,v 1.15 2003/06/25 22:34:24 vapier Exp $

inherit kde-base

DESCRIPTION="Archiver with passwd management"
SRC_URI="mirror://sourceforge/kfilecoder/${P}.tar.bz2"
HOMEPAGE="http://kfilecoder.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 sparc"

need-kde 2.1.1

src_compile() {
	rm config.cache
	kde_src_compile
}

src_install() {
	make DESTDIR=${D} kde_locale=${D}/usr/share/locale install || die
	kde_src_install dodoc
}
