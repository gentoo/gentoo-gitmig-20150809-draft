# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/youtube-servicemenu/youtube-servicemenu-1.3f.ebuild,v 1.1 2007/11/20 14:11:07 hanno Exp $

DESCRIPTION="Download YouTube (tm) Videos"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Get+YouTube+Video+(improved)?content=41456"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/41456-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python
	|| ( kde-base/konqueror kde-base/kdenetwork )"

LANGS="de ru sk uk"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dobin get_yt_video.py

	insinto /usr/share/apps/konqueror/servicemenus
	doins get_yt_video.desktop

	cd "${WORKDIR}/${P}/l10n"
	for X in ${LANGS} ; do
		use linguas_${X} && insinto /usr/share/locale/${X}/LC_MESSAGES
		use linguas_${X} && doins ${X}/LC_MESSAGES/get_yt_video.mo
	done
}
