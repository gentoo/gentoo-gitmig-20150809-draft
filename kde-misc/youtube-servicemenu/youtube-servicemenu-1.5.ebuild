# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/youtube-servicemenu/youtube-servicemenu-1.5.ebuild,v 1.1 2008/08/29 09:13:05 hanno Exp $

DESCRIPTION="Download YouTube (tm) Videos"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Get+YouTube+Video+(improved)?content=41456"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/41456-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python
	|| ( =kde-base/konqueror-3.5* =kde-base/kdenetwork-3.5* )"

LANGS="de ru sk uk"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_compile() {
	:
}

src_install() {
	dobin get_yt_video.py || die "dobin failed."

	insinto /usr/share/apps/konqueror/servicemenus
	doins get_yt_video.desktop || die "doins failed."

	cd "${WORKDIR}/${P}/l10n"
	for X in ${LANGS} ; do
		if use linguas_${X}; then
			insinto /usr/share/locale/${X}/LC_MESSAGES
			doins ${X}/LC_MESSAGES/get_yt_video.mo || die "doins failed."
		fi
	done
}
