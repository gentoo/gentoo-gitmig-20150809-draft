# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.8.0.ebuild,v 1.1 2006/12/22 11:23:59 flameeyes Exp $

inherit kde

DESCRIPTION="Smb4K is a SMB share browser for KDE"
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="|| ( kde-base/konqueror kde-base/kdebase )"
RDEPEND="${DEPEND}
	net-fs/samba"
need-kde 3.4
