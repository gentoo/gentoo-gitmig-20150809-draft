# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kpopper/kpopper-1.0.ebuild,v 1.8 2002/07/11 06:30:48 drobbins Exp $

inherit kde-base || die

need-kde 3

S="${WORKDIR}/popper-1.0"
LICENSE="GPL-2"
DESCRIPTION="A very simple, easy-to-use and functional network messager."
SRC_URI="mirror://sourceforge/kpopper/popper-1.0.tar.gz"
HOMEPAGE="http://kpopper.sourceforge.net/"
KEYWORDS="x86"

newdepend ">=net-fs/samba-2.2"

