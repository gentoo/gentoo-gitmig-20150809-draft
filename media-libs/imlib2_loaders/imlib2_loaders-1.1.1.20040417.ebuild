# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2_loaders/imlib2_loaders-1.1.1.20040417.ebuild,v 1.1 2004/04/19 03:47:27 vapier Exp $

EHACKAUTOGEN=YES
EHACKLIBLTDL=YES
inherit enlightenment

DESCRIPTION="image loader plugins for Imlib 2"
HOMEPAGE="http://www.enlightenment.org/pages/imlib2.html"

IUSE="${IUSE} X"

RDEPEND=">=media-libs/imlib2-1.1.0
	>=dev-db/edb-1.0.4.20031013
	>=dev-libs/eet-0.9.0.20031013"

src_compile() {
	export MY_ECONF="
		--enable-eet
		--enable-edb
	"
	enlightenment_src_compile
}
