# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2_loaders/imlib2_loaders-1.2.1.004.ebuild,v 1.1 2005/08/20 05:28:43 vapier Exp $

inherit enlightenment

DESCRIPTION="image loader plugins for Imlib 2"

RDEPEND=">=media-libs/imlib2-1.2.0
	>=dev-db/edb-1.0.5
	>=dev-libs/eet-0.9.9"

src_compile() {
	export MY_ECONF="
		--enable-eet
		--enable-edb
	"
	enlightenment_src_compile
}
