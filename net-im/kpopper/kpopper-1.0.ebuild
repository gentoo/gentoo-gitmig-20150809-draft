# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kpopper/kpopper-1.0.ebuild,v 1.2 2004/03/14 17:26:06 mr_bones_ Exp $

inherit kde

need-kde 3

S="${WORKDIR}/popper-1.0"
LICENSE="GPL-2"
DESCRIPTION="A very simple, easy-to-use and functional network messager."
SRC_URI="mirror://sourceforge/kpopper/popper-1.0.tar.gz"
HOMEPAGE="http://kpopper.sourceforge.net/"
KEYWORDS="x86 sparc "

newdepend ">=net-fs/samba-2.2"

