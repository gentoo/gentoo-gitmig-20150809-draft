# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2_loaders/imlib2_loaders-1.2.0.20041208.ebuild,v 1.1 2004/12/10 16:29:34 vapier Exp $

EHACKAUTOGEN=YES
EAUTOMAKE=1.6
inherit enlightenment

DESCRIPTION="image loader plugins for Imlib 2"
HOMEPAGE="http://www.enlightenment.org/pages/imlib2.html"

RDEPEND=">=media-libs/imlib2-1.1.2
	>=dev-db/edb-1.0.5
	>=dev-libs/eet-0.9.9"

src_compile() {
	export MY_ECONF="
		--enable-eet
		--enable-edb
	"
	enlightenment_src_compile
}
