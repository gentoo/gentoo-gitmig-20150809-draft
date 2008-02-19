# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kuroo/kuroo-0.80.2-r1.ebuild,v 1.7 2008/02/19 01:31:11 ingmar Exp $

inherit kde eutils

DESCRIPTION="Kuroo is a KDE Portage frontend."
HOMEPAGE="http://kuroo.org/"
SRC_URI="http://files.kuroo.org/files/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="app-portage/gentoolkit
	kde-misc/kdiff3
	|| ( =kde-base/kdesu-3.5* =kde-base/kdebase-3.5* )"

need-kde 3.2

src_unpack() {
	kde_src_unpack

	# Fix the desktop file for compliance with the spec. Fixes bug 188755.
	epatch "${FILESDIR}/${PN}-desktop-file.patch"
}
