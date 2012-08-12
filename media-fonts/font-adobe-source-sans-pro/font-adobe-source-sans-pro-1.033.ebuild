# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-adobe-source-sans-pro/font-adobe-source-sans-pro-1.033.ebuild,v 1.1 2012/08/12 14:19:06 ssuominen Exp $

EAPI=4
inherit font

MY_P=SourceSansPro_FontsOnly-${PV}

DESCRIPTION="Adobe's first open source type family"
HOMEPAGE="http://blogs.adobe.com/typblography/2012/08/source-sans-pro.html http://sourceforge.net/projects/sourcesans.adobe/"
SRC_URI="mirror://sourceforge/sourcesans.adobe/${MY_P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_P}

FONT_SUFFIX=otf
FONT_S=${S}/OTF

# From .spec of http://bugzilla.redhat.com/show_bug.cgi?id=845743
FONT_CONF=( "${FILESDIR}"/63-${PN}.conf )

src_install() {
	font_src_install
	dohtml *.html
}
