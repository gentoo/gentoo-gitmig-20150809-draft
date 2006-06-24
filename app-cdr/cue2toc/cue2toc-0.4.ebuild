# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cue2toc/cue2toc-0.4.ebuild,v 1.1 2006/06/24 10:56:38 sbriesen Exp $

inherit eutils

DESCRIPTION="Convert CUE files to cdrdao's TOC format"
HOMEPAGE="http://cue2toc.sourceforge.net/"
SRC_URI="mirror://sourceforge/cue2toc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
