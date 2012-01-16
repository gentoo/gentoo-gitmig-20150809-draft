# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmouth/kmouth-4.7.4.ebuild,v 1.3 2012/01/16 22:54:44 ago Exp $

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

DESCRIPTION="KDE application that reads what you type out loud. Doesn't include a speech synthesizer."
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"
