# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-strigi-analyzer/kdepim-strigi-analyzer-4.4.4.ebuild,v 1.2 2010/06/21 15:53:12 scarabeus Exp $

EAPI="3"

KMNAME="kdepim"
KMMODULE="strigi-analyzer"
inherit kde4-meta

DESCRIPTION="kdepim: strigi plugins"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-misc/strigi
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"
