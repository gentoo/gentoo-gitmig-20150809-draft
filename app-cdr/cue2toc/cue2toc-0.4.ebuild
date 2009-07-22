# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cue2toc/cue2toc-0.4.ebuild,v 1.3 2009/07/22 12:56:36 aballier Exp $

DESCRIPTION="Convert CUE files to cdrdao's TOC format"
HOMEPAGE="http://cue2toc.sourceforge.net/"
SRC_URI="mirror://sourceforge/cue2toc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="!app-cdr/cdrdao"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
