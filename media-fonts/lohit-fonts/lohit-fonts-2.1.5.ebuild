# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lohit-fonts/lohit-fonts-2.1.5.ebuild,v 1.8 2008/03/13 12:38:27 coldwind Exp $

inherit font

S="${WORKDIR}/fonts-indic-${PV}"
FONT_S="${S}"
FONTDIR="/usr/share/fonts/indic"
FONT_SUFFIX="ttf"

DESCRIPTION="The Lohit family of indic fonts"
HOMEPAGE="http://fedoraproject.org/wiki/Lohit"
LICENSE="GPL-2"
SRC_URI="mirror://gentoo/fonts-indic-${PV}.tar.gz"

SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DOCS="AUTHORS ChangeLog"

src_compile() {
	find ./ -name '*ttf' -exec  cp {} . \;
}
