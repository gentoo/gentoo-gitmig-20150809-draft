# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaccessible/kaccessible-4.7.3.ebuild,v 1.3 2011/12/07 22:14:01 hwoarang Exp $

EAPI=4

KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	kde_eclass="kde4-base"
else
	KMNAME="kdeaccessibility"
	kde_eclass="kde4-meta"
fi
inherit ${kde_eclass}

DESCRIPTION="Provides accessibility services like focus tracking"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +speechd"

DEPEND="app-accessibility/speech-dispatcher"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with speechd Speechd)
	)
	${kde_eclass}_src_configure
}
