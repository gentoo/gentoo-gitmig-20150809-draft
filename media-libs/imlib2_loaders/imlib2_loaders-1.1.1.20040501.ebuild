# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2_loaders/imlib2_loaders-1.1.1.20040501.ebuild,v 1.4 2004/07/14 19:49:46 agriffis Exp $

EHACKAUTOGEN=YES
inherit enlightenment

DESCRIPTION="image loader plugins for Imlib 2"
HOMEPAGE="http://www.enlightenment.org/pages/imlib2.html"

IUSE=""

RDEPEND=">=media-libs/imlib2-1.1.0
	>=dev-db/edb-1.0.4.20031013
	>=dev-libs/eet-0.9.0.20031013"

src_compile() {
	export MY_ECONF="
		--enable-eet
		--enable-edb
	"
	export WANT_AUTOMAKE=1.6 #48783
	enlightenment_src_compile
}
