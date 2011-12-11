# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/jovie/jovie-4.7.4.ebuild,v 1.1 2011/12/11 18:52:23 alexxy Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	kde_eclass="kde4-base"
else
	KMNAME="kdeaccessibility"
	kde_eclass="kde4-meta"
fi

inherit ${kde_eclass}

DESCRIPTION="Jovie is a text to speech application"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-accessibility/speech-dispatcher
"
RDEPEND="${DEPEND}"
