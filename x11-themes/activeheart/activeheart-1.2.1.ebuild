# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/activeheart/activeheart-1.2.1.ebuild,v 1.2 2004/08/30 19:44:41 pvdabeel Exp $

inherit kde-base

need-kde 3.2

KLV=11384
DESCRIPTION="A cool kde style based on Keramik Style Engine"
SRC_URI="http://www.kde-look.org/content/files/${KLV}-${P}.tar.bz2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="${KDEMAJORVER}.${KDEMINORVER}"
KEYWORDS="~x86 ~amd64 ~ppc"
