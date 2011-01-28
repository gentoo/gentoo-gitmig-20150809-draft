# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krusader/krusader-2.3.0_beta1.ebuild,v 1.2 2011/01/28 12:47:40 scarabeus Exp $

EAPI=3

KDE_LINGUAS="bg ca cs da de el en_GB es et fr gl hr hu it ja ko lt mai nb nds
nl pl pt pt_BR ro ru sk sl sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
inherit kde4-base

MY_P="${P/_/-}"

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://www.krusader.org/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="4"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="debug handbook"

RDEPEND="
	$(add_kdebase_dep libkonq)
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

S="${WORKDIR}/${MY_P}"
