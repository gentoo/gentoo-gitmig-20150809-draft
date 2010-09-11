# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.10.9.ebuild,v 1.1 2010/09/11 21:54:40 scarabeus Exp $

EAPI=2
KDE_LINGUAS="bg cs da de es fr hu is it ja nb nl pl pt_BR ru sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc"
inherit kde4-base

DESCRIPTION="The advanced network neighborhood browser for KDE"
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug +handbook"

RDEPEND=">=net-fs/samba-3.4.2[cups]"

DOCS="AUTHORS BUGS ChangeLog FAQ README TODO"
