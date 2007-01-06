# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiv2/exiv2-0.12.ebuild,v 1.2 2007/01/06 20:07:20 sbriesen Exp $

inherit eutils

DESCRIPTION="Exiv2 is a C++ library and a command line utility to access image metadata"
HOMEPAGE="http://www.exiv2.org/"
SRC_URI="http://www.exiv2.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="doc unicode"

DEPEND="sys-libs/zlib
	virtual/libiconv"
RDEPEND="sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use unicode; then
		einfo "Converting docs to UTF-8"
		for i in doc/cmd.txt; do
			iconv -f LATIN1 -t UTF-8 "${i}" > "${i}~" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README doc/{ChangeLog,cmd.txt}
	use doc && dohtml doc/html/*
}

pkg_postinst() {
	ewarn
	ewarn "PLEASE PLEASE take note of this:"
	ewarn "Please make *sure* to run revdep-rebuild now"
	ewarn "Certain things on your system may have linked against a"
	ewarn "different version of exiv2 -- those things need to be"
	ewarn "recompiled.  Sorry for the inconvenience"
	ewarn
}
