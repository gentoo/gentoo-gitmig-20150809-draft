# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.4.1a.ebuild,v 1.3 2005/01/11 17:13:48 carlo Exp $

inherit kde

DESCRIPTION="Smb4K is a SMB share browser for KDE 3.2.x."
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="http://download.berlios.de/smb4k/${P}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"

RDEPEND="net-fs/samba"
need-kde 3.2

