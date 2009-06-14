# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/knoda/knoda-0.7.1.ebuild,v 1.7 2009/06/14 10:01:35 scarabeus Exp $

inherit kde eutils

DESCRIPTION="KDE database frontend based on the hk_classes library"
HOMEPAGE="http://hk-classes.sourceforge.net/"
SRC_URI="mirror://sourceforge/knoda/${P}.tar.bz2"

SLOT="3.5"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE="arts"

DEPEND=">=dev-db/hk_classes-${PV}"
need-kde 3

src_unpack() {
	kde_src_unpack

	useq arts || epatch ${FILESDIR}/${P}-configure.patch
}
