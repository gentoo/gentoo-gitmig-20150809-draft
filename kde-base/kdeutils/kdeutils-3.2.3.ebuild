# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.2.3.ebuild,v 1.10 2005/02/08 14:53:40 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="x86 ppc sparc ~alpha hppa amd64 ~ia64 ~mips"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"

src_unpack()
{
	kde_src_unpack
}
