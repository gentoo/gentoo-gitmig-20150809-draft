# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/zvbi/zvbi-0.2.16.ebuild,v 1.1 2005/06/20 11:16:54 hanno Exp $

IUSE="X nls v4l dvb doc"

DESCRIPTION="VBI Decoding Library for Zapping"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64 ~alpha ~ia64"

DEPEND="X? (virtual/x11)
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

src_compile() {
	local myconf="`use_enable nls` \
		`use_enable v4l` \
		`use_enable dvb` "

	use X && myconf="${myconf} --with-x"
	use X || myconf="${myconf} --without-x"

	econf ${myconf} || die

	cp doc/zdoc-scan doc/zdoc-scan.orig
	sed -e 's:usr/local/share/gtk-doc:usr/share/gtk-doc:' \
		doc/zdoc-scan.orig > doc/zdoc-scan
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	use doc && dohtml -a png,gif,html,css doc/html/*
}
