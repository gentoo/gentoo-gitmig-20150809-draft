# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/wicd-client-kde/wicd-client-kde-0.2.1.ebuild,v 1.4 2011/02/26 11:19:29 tomka Exp $

EAPI=3
KDE_LINGUAS_DIR="translations"
KDE_LINGUAS="cs es fr hu it pt_BR zh_CN"
inherit kde4-base

DESCRIPTION="Wicd client built on the KDE Development Platform"
HOMEPAGE="http://kde-apps.org/content/show.php/Wicd+Client+KDE?content=132366"
SRC_URI="http://kde-apps.org/CONTENT/content-files/132366-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="net-misc/wicd[-X,-gtk]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}
