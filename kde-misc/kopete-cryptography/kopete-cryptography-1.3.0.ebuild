# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kopete-cryptography/kopete-cryptography-1.3.0.ebuild,v 1.2 2009/02/03 21:41:21 mr_bones_ Exp $

EAPI="2"
KDE_MINIMAL="4.1"
KDE_LINGUAS="ar be cs de el es et fr ga gl hi it ja km lt nb nds nl
			nn oc pa pt pt_BR ro sv tr uk zh_CN zh_TW"

inherit kde4-base

KDE_VERSION="4.2.0"
MY_P="${P}-kde${KDE_VERSION}"

DESCRIPTION="Cryptography for Kopete instant messenger."
HOMEPAGE="http://www.kde.org"
SRC_URI="mirror://kde/stable/${KDE_VERSION}/src/extragear/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/kopete-${KDE_MINIMAL}"

S="${WORKDIR}/${MY_P}"

pkg_postinst() {
	elog "You can now enable and set up the Cryptography   plugin in Kopete."
	elog "It can be reached in the Kopete Plugin dialog."
}
