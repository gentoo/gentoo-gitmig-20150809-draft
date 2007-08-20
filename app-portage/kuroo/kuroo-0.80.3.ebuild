# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kuroo/kuroo-0.80.3.ebuild,v 1.2 2007/08/20 16:22:02 philantrop Exp $

inherit kde eutils

DESCRIPTION="Kuroo is a KDE Portage frontend."
HOMEPAGE="http://kuroo.org/"
SRC_URI="http://files.kuroo.org/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="app-portage/gentoolkit
	kde-misc/kdiff3
	|| ( kde-base/kdesu kde-base/kdebase )"

need-kde 3.5

src_unpack() {
	kde_src_unpack

	# Fix the desktop file for compliance with the spec. Fixes bug 188755.
	epatch "${FILESDIR}/${PN}-desktop-file.patch"
}
