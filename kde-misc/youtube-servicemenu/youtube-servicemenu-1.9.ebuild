# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/youtube-servicemenu/youtube-servicemenu-1.9.ebuild,v 1.1 2010/11/14 14:04:29 dilfridge Exp $

EAPI="2"

PYTHON_DEPEND="2"
inherit python

DESCRIPTION="Download YouTube (tm) Videos"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Get+YouTube+Video+(improved)?content=41456"
SRC_URI="http://kde-apps.org/CONTENT/content-files/41456-${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

MY_LINGUAS="de es ru sk uk"
for x in ${MY_LINGUAS}; do
	IUSE="${IUSE} linguas_${x}"
done

RDEPEND="
	>=kde-base/konqueror-4.3.1
"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	dobin get_yt_video.py || die

	insinto /usr/share/kde4/services
	doins get_yt_video.desktop || die

	for x in ${MY_LINGUAS}; do
		if use linguas_${x}; then
			insinto /usr/share/locale/${x}/LC_MESSAGES
			doins l10n/${x}/LC_MESSAGES/get_yt_video.mo || die
		fi
	done
}
