# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.10.74.ebuild,v 1.1 2011/09/29 08:55:07 scarabeus Exp $

EAPI=4
KDE_LINGUAS="bg cs da de en_GB eo es et fr ga gl hu is it ja lt mai nb nds nl
pl pt pt_BR ru sk sv tr ug uk zh_CN zh_TW"
KDE_HANDBOOK="optional"
KDE_DOC_DIRS="doc doc-translations"
QT_MINIMAL="4.7"
inherit kde4-base

DESCRIPTION="The advanced network neighborhood browser for KDE"
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

RDEPEND=">=net-fs/samba-3.4.2[cups]"

DOCS="AUTHORS BUGS ChangeLog FAQ README TODO"

src_configure() {
	local mycmakeargs=(
		"-DCOMPILE_KIOSLAVE=ON"
	)
	kde4-base_src_configure
}
