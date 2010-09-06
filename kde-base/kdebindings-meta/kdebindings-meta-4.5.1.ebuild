# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-4.5.1.ebuild,v 1.2 2010/09/06 04:50:49 reavertm Exp $

EAPI="3"
inherit kde4-functions

DESCRIPTION="KDE bindings - merge this to pull in all kdebindings-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.5"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="aqua csharp java kdeprefix perl python ruby"

RDEPEND="
	$(add_kdebase_dep smoke)
	csharp? ( $(add_kdebase_dep kdebindings-csharp) )
	java? ( $(add_kdebase_dep krossjava) )
	perl? ( $(add_kdebase_dep kdebindings-perl) )
	python? (
		$(add_kdebase_dep krosspython)
		$(add_kdebase_dep pykde4)
	)
	ruby? ( $(add_kdebase_dep kdebindings-ruby) )
	$(block_other_slots)
"
