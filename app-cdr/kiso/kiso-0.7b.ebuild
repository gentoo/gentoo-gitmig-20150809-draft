# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kiso/kiso-0.7b.ebuild,v 1.1 2004/11/11 23:15:02 motaboy Exp $

inherit kde

S="${WORKDIR}/${PN}-0.7"

DESCRIPTION="KIso is a fronted for KDE to make it as easy as possible to create manipulate and extract CD Image files."
HOMEPAGE="http://kiso.sourceforge.net/"
SRC_URI="mirror://sourceforge/kiso/${PN}-0.7.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libcdio-0.70"
RDEPEND="${DEPEND}
	app-cdr/cdrtools
	app-admin/sudo"

need-kde 3.2

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-dirops.h.patch
}
