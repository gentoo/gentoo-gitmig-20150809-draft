# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.3.2.ebuild,v 1.2 2004/06/25 00:11:56 agriffis Exp $

inherit kde
need-kde 3.1

DESCRIPTION="Smb4K is a SMB share browser for KDE 3.1.x."
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="http://download.berlios.de/smb4k/${P}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="$RDEPEND
	sys-libs/zlib"



