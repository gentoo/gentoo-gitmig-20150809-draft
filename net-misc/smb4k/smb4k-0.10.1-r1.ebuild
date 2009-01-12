# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.10.1-r1.ebuild,v 1.1 2009/01/12 17:57:05 scarabeus Exp $

EAPI="2"
KDE_MINIMAL="4.1"
KDE_LINGUAS="bg cs da de es fr hu is it ja nb nl pt pt_BR ru sk sv tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="Smb4K is a SMB share browser for KDE."
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

SLOT="4.1"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="bindist"

COMMON_DEPEND=">=kde-base/konqueror-${KDE_MINIMAL}"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	bindist? ( <net-fs/samba-3.2.0_rc2 )
	!bindist? ( net-fs/samba )
	!kdeprefix? ( !net-misc/smb4k:0 )
	net-fs/mount-cifs"
