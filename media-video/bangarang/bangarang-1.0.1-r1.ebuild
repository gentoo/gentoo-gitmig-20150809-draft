# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bangarang/bangarang-1.0.1-r1.ebuild,v 1.2 2011/02/02 04:55:48 tampakrap Exp $

EAPI=3

KDE_LINGUAS="cs de fr it nl pl pt_BR zh_CN"
KDE_LINGUAS_DIR="translations"

inherit kde4-base

DESCRIPTION="A media player for KDE utilizing Nepomuk for tagging"
HOMEPAGE="http://bangarangkde.wordpress.com"
SRC_URI="http://opendesktop.org/CONTENT/content-files/113305-${P}.tar.gz"
#EGIT_REPO_URI="git://gitorious.org/bangarang/bangarang.git"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop')
	$(add_kdebase_dep kdemultimedia-kioslaves)
	media-libs/taglib
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

S=${WORKDIR}/${PN}-${PN}

src_prepare() {
	kde4-base_src_prepare

	# Rename invalid Czech locale location from cz to cs
	sed -e 's/ cz ALL/ cs ALL/' \
		-i translations/cz/CMakeLists.txt || die
	mv translations/{cz,cs} || die
	sed -e 's/add_subirectory( cz )/add_subirectory( cs )/' \
		-i translations/CMakeLists.txt || die
}
