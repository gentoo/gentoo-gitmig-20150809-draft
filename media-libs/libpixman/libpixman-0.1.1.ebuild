# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpixman/libpixman-0.1.1.ebuild,v 1.11 2004/12/09 19:44:34 gustavoz Exp $

DESCRIPTION="A generic library for manipulating pixel regions"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 mips ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make install DESTDIR=${D} || die
}
