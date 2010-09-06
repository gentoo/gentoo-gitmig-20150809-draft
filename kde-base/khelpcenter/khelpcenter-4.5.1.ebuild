# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khelpcenter/khelpcenter-4.5.1.ebuild,v 1.1 2010/09/06 00:34:42 tampakrap Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Help Center"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	>=www-misc/htdig-3.2.0_beta6-r1
"

src_unpack() {
	if use handbook; then
		KMEXTRA="
			doc/glossary
			doc/onlinehelp
		"
	fi

	kde4-meta_src_unpack
}
