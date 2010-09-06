# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/jovie/jovie-4.5.1.ebuild,v 1.2 2010/09/06 04:50:44 reavertm Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdeaccessibility"

inherit kde4-meta

DESCRIPTION="Jovie is a text to speech application"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	app-accessibility/speech-dispatcher
"
RDEPEND="${DEPEND}"

# Renamed from kttsd just after 4.4.80
add_blocker kttsd
