# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.5.0_pre2.ebuild,v 1.1 2004/12/02 16:28:57 carlo Exp $

inherit kde

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Smb4K is a SMB share browser for KDE 3.2.x."
HOMEPAGE="http://smb4k.berlios.de/"
#SRC_URI="http://download.berlios.de/smb4k/${MY_P}.tar.gz"
SRC_URI="ftp://ftp.berlios.de/pub/smb4k/testing/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

RDEPEND="net-fs/samba"
need-kde 3.2

