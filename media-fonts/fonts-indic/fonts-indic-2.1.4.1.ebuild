# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/fonts-indic/fonts-indic-2.1.4.1.ebuild,v 1.1 2007/03/10 15:17:22 seemant Exp $

inherit rpm font versionator

MY_PV="$(replace_version_separator 3 '-')"

MY_P="${PN}-${MY_PV}.fc7"
S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"
FONT_S="${S}"
FONT_PN="indic"
FONTDIR="/usr/share/fonts/${FONT_PN}"
FONT_SUFFIX="ttf"

DESCRIPTION="The Lohit family of indic fonts"
HOMEPAGE="http://fedoraproject.org/wiki/Lohit"
LICENSE="GPL-2"
SRC_URI="http://redhat.download.fedoraproject.org/pub/fedora/linux/core/development/source/SRPMS/${MY_P}.src.rpm"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DOCS="AUTHORS ChangeLog"

src_compile() {
	find ./ -name '*ttf' -exec  cp {} . \;
}
