# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcaca/libcaca-0.9.ebuild,v 1.1 2004/02/22 14:08:47 hanno Exp $

IUSE="ncurses slang doc imlib"

DESCRIPTION="A library that creates colored ASCII-art graphics"
HOMEPAGE="http://sam.zoy.org/projects/libcaca"
SRC_URI="http://sam.zoy.org/projects/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="
	ncurses? ( >=sys-libs/ncurses-5.3 )
	slang? ( >=sys-libs/slang-1.4.2 )
	doc? ( app-doc/doxygen )"

src_compile() {

	econf \
	    `use_enable doc` \
	    `use_enable ncuses` \
	    `use_enable slang` \
	    `use_enable imlib imlib2` \
	    || die

	emake || die
	}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS NOTES \
	README TODO
}
