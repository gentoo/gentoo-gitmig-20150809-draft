# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.5.2.ebuild,v 1.3 2005/10/26 08:56:46 greg_g Exp $

inherit kde

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A SMB share browser for KDE."
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="http://download.berlios.de/smb4k/${MY_P}.tar.gz"
#SRC_URI="ftp://ftp.berlios.de/pub/smb4k/testing/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="net-fs/samba"
need-kde 3.2

