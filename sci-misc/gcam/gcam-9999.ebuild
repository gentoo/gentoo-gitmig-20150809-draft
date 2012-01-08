# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/gcam/gcam-9999.ebuild,v 1.1 2012/01/08 18:38:00 dilfridge Exp $

EAPI=4

ESVN_REPO_URI="http://gcam.js.cx/svn/gcam/trunk"
ESVN_USER=gcam
ESVN_PASSWORD=gcam
inherit base autotools subversion

DESCRIPTION="GNU Computer Aided Manufacturing"
HOMEPAGE="http://gcam.js.cx"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/gtk+:2
	x11-libs/gtkglext"
RDEPEND="${DEPEND}"

src_prepare() {
	base_src_prepare
	eautoreconf
}
