# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/zvbi/zvbi-0.2.4.ebuild,v 1.7 2006/01/15 23:34:40 flameeyes Exp $

IUSE="nls"

DESCRIPTION="VBI Decoding Library for Zapping"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"

DEPEND="virtual/x11
	nls? ( sys-devel/gettext )"

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die

	cp doc/zdoc-scan doc/zdoc-scan.orig
	sed -e 's:usr/local/share/gtk-doc:usr/share/gtk-doc:' \
		doc/zdoc-scan.orig > doc/zdoc-scan
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
