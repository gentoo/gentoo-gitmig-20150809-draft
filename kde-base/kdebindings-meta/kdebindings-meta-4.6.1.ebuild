# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-4.6.1.ebuild,v 1.1 2011/03/04 17:59:56 alexxy Exp $

EAPI=3
inherit kde4-functions

DESCRIPTION="KDE bindings - merge this to pull in all kdebindings-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.6"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
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
