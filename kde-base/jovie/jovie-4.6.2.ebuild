# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/jovie/jovie-4.6.2.ebuild,v 1.1 2011/04/06 14:19:03 scarabeus Exp $

EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdeaccessibility"

inherit kde4-meta

DESCRIPTION="Jovie is a text to speech application"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-accessibility/speech-dispatcher
"
RDEPEND="${DEPEND}"

# Renamed from kttsd just after 4.4.80
add_blocker kttsd
