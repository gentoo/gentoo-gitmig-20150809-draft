# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kportage/kportage-0.5.1-r1.ebuild,v 1.4 2003/02/13 05:25:19 vapier Exp $

inherit kde-base
need-kde 3

PATCHES="${FILESDIR}/${P}.diff"
IUSE=""
DESCRIPTION="A graphical frontend for portage"
SRC_URI="http://freesoftware.fsf.org/download/${PN}/${PN}.pkg/0.5/${P}.tar.bz2"
HOMEPAGE="http://www.freesoftware.fsf.org/kportage/"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc"

newdepend "	kde-base/kdebase
	>=sys-apps/portage-2.0.26"
