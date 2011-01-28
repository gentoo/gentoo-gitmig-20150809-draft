# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konsolekalendar/konsolekalendar-4.4.9.ebuild,v 1.3 2011/01/28 19:46:19 tomka Exp $

EAPI="3"

KMNAME="kdepim"
KMMODULE="console/${PN}"
inherit kde4-meta

DESCRIPTION="A command line interface to KDE calendars"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"
