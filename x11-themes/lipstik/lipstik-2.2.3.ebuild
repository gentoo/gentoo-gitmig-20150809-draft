# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/lipstik/lipstik-2.2.3.ebuild,v 1.2 2008/12/31 03:44:57 mr_bones_ Exp $

inherit kde

KLV=18223
DESCRIPTION="Lipstik is a purified style with many options to tune your
desktop look"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=18223"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/${KLV}-${P}.tar.gz"
IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

need-kde 3.3
