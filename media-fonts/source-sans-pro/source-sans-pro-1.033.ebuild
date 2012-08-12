# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/source-sans-pro/source-sans-pro-1.033.ebuild,v 1.1 2012/08/12 14:31:13 ssuominen Exp $

EAPI=4
inherit font

MY_P=SourceSansPro_FontsOnly-${PV}

DESCRIPTION="Adobe Source Sans Pro, an open source multi-lingual font family"
HOMEPAGE="http://blogs.adobe.com/typblography/2012/08/source-sans-pro.html"
SRC_URI="mirror://sourceforge/sourcesans.adobe/${MY_P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

RDEPEND="media-libs/fontconfig"
DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_P}

FONT_SUFFIX="otf ttf"
FONT_S=${S}
# From .spec of http://bugzilla.redhat.com/show_bug.cgi?id=845743
FONT_CONF=( "${FILESDIR}"/63-${PN}.conf )

src_prepare() {
	# Put otf and ttf files in one directory so that font_src_install can
	# actually find them
	mv -vf {OTF,TTF}/* . || die
}

src_install() {
	font_src_install
	dohtml *.html
}
