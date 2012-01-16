# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-meta/kdepim-meta-4.7.4.ebuild,v 1.3 2012/01/16 22:21:45 ago Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="kdepim - merge this to pull in all kdepim-derived packages"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep akonadiconsole)
	$(add_kdebase_dep akregator)
	$(add_kdebase_dep blogilo)
	$(add_kdebase_dep kabcclient)
	$(add_kdebase_dep kaddressbook)
	$(add_kdebase_dep kalarm)
	$(add_kdebase_dep kdepim-icons)
	$(add_kdebase_dep kdepim-kresources)
	$(add_kdebase_dep kdepim-runtime)
	$(add_kdebase_dep kdepim-strigi-analyzer)
	$(add_kdebase_dep kdepim-wizards)
	$(add_kdebase_dep kjots)
	$(add_kdebase_dep kleopatra)
	$(add_kdebase_dep kmail)
	$(add_kdebase_dep knode)
	$(add_kdebase_dep knotes)
	$(add_kdebase_dep konsolekalendar)
	$(add_kdebase_dep kontact)
	$(add_kdebase_dep korganizer)
	$(add_kdebase_dep ktimetracker)
"
