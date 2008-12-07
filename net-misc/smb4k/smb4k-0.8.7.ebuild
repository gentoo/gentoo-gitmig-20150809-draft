# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.8.7.ebuild,v 1.5 2008/12/07 13:16:51 jmbsvicetto Exp $

inherit kde

DESCRIPTION="Smb4K is a SMB share browser for KDE"
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="|| ( kde-base/konqueror kde-base/kdebase )"
RDEPEND="${DEPEND}
	net-fs/samba"
need-kde 3.5
