# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kpopper/kpopper-1.0.ebuild,v 1.4 2004/07/03 21:17:17 carlo Exp $

inherit kde

S="${WORKDIR}/popper-1.0"

DESCRIPTION="A very simple, easy-to-use and functional network messager."
HOMEPAGE="http://kpopper.sourceforge.net/"
SRC_URI="mirror://sourceforge/kpopper/popper-1.0.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND=">=net-fs/samba-2.2"
need-kde 3