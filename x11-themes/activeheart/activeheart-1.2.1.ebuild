# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/activeheart/activeheart-1.2.1.ebuild,v 1.4 2005/02/03 21:29:19 carlo Exp $

inherit kde

KLV=11384
DESCRIPTION="A cool kde style based on Keramik Style Engine"
SRC_URI="http://www.kde-look.org/content/files/${KLV}-${P}.tar.bz2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

need-kde 3.2