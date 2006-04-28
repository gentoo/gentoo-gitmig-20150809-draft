# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiv2/exiv2-0.9.1.ebuild,v 1.3 2006/04/28 21:29:11 weeve Exp $

inherit eutils

DESCRIPTION="Exiv2 is a C++ library and a command line utility to access image metadata"
HOMEPAGE="http://www.exiv2.org/"
SRC_URI="http://www.exiv2.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README doc/{ChangeLog,cmd.txt}
	use doc && dohtml doc/html/*
}
