# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kportage/kportage-0.5.ebuild,v 1.8 2002/11/02 23:26:54 gerk Exp $

inherit kde-base

need-kde 3

DESCRIPTION="A graphical frontend for portage"
SRC_URI="http://freesoftware.fsf.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.freesoftware.fsf.org/kportage/"

LICENSE="GPL-2"
KEYWORDS="x86 -ppc sparc sparc64"

newdepend "	kde-base/kdebase
	>=sys-apps/portage-2.0.26"

IUSE=""
