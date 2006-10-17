# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiv2/exiv2-0.11.ebuild,v 1.2 2006/10/17 22:44:53 sbriesen Exp $

inherit eutils

DESCRIPTION="Exiv2 is a C++ library and a command line utility to access image metadata"
HOMEPAGE="http://www.exiv2.org/"
SRC_URI="http://www.exiv2.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc unicode"

DEPEND="sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use unicode; then
		einfo "Converting docs to UTF-8"
		for i in doc/cmd.txt; do
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README doc/{ChangeLog,cmd.txt}
	use doc && dohtml doc/html/*
}
