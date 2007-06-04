# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/baghira/baghira-0.7.ebuild,v 1.10 2007/06/04 21:24:02 armin76 Exp $

inherit kde

DESCRIPTION="Baghira - an OS-X like style for KDE"
HOMEPAGE="http://baghira.sourceforge.net/"
SRC_URI="mirror://sourceforge/baghira/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( kde-base/kwin >=kde-base/kdebase-3.3 )
	|| ( kde-base/konqueror >=kde-base/kdebase-3.3 )"

need-kde 3.3

S="${WORKDIR}/${PN}-release"

PATCHES="${FILESDIR}/${P}-gcc41.patch"
