# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/zvbi/zvbi-0.2.8.ebuild,v 1.1 2004/08/29 11:36:56 mholzer Exp $

IUSE="nls"

DESCRIPTION="VBI Decoding Library for Zapping"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64 ~alpha ~ia64"

DEPEND="virtual/x11
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die

	cp doc/zdoc-scan doc/zdoc-scan.orig
	sed -e 's:usr/local/share/gtk-doc:usr/share/gtk-doc:' \
		doc/zdoc-scan.orig > doc/zdoc-scan
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
