# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpixman/libpixman-0.1.1.ebuild,v 1.7 2004/09/03 15:28:36 pvdabeel Exp $

DESCRIPTION="A generic library for manipulating pixel regions"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make install DESTDIR=${D}
}
