# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cuetools/cuetools-1.3-r1.ebuild,v 1.1 2006/02/04 18:17:06 sbriesen Exp $

inherit eutils

DESCRIPTION="Utilities to manipulate and convert cue and toc files"
HOMEPAGE="http://developer.berlios.de/projects/cuetools/"
SRC_URI="http://download.berlios.de/cuetools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# apply patches, see:
	# http://developer.berlios.de/bugs/?func=detailbug&bug_id=4180&group_id=2130
	# http://developer.berlios.de/bugs/?func=detailbug&bug_id=4831&group_id=2130
	epatch "${FILESDIR}/${P}.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS README TODO
}
