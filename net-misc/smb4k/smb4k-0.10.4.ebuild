# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.10.4.ebuild,v 1.3 2009/11/09 19:58:15 fauli Exp $

EAPI="2"

KDE_LINGUAS="bg cs da de es fr hu is it ja ko_KR nb nl pl pt_BR ru sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc"
inherit kde4-base

DESCRIPTION="Smb4K is a SMB share browser for KDE."
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
SLOT="4"
IUSE="debug handbook"

RDEPEND="
	|| ( >=net-fs/samba-client-3.4.2 net-fs/mount-cifs )
	>=kde-base/konqueror-${KDE_MINIMAL}
"
DEPEND="${RDEPEND}"
