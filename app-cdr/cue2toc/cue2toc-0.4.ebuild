# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cue2toc/cue2toc-0.4.ebuild,v 1.6 2009/11/07 15:17:51 volkmar Exp $

DESCRIPTION="Convert CUE files to cdrdao's TOC format"
HOMEPAGE="http://cue2toc.sourceforge.net/"
SRC_URI="mirror://sourceforge/cue2toc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="!app-cdr/cdrdao"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
