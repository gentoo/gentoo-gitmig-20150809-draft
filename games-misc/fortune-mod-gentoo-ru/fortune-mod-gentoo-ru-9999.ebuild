# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-gentoo-ru/fortune-mod-gentoo-ru-9999.ebuild,v 1.1 2011/10/30 17:59:00 pva Exp $

EAPI="4"

inherit mercurial

DESCRIPTION="Fortune database of quotes from gentoo.ru forum and gentoo@conference.gentoo.ru"
HOMEPAGE="http://marsoft.dyndns.info/fortunes-gentoo-ru/"
SRC_URI=""
EHG_REPO_URI="https://gentoo-ru-fortunes.slepnoga.googlecode.com/hg"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="games-misc/fortune-mod"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	mv gentoo-ru-9999 gentoo-ru || die
}

src_compile() {
	strfile gentoo-ru || die
}

src_install() {
	insinto /usr/share/fortune
	doins gentoo-ru gentoo-ru.dat
}
