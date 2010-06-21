# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kontact-specialdates/kontact-specialdates-4.3.5.ebuild,v 1.4 2010/06/21 15:53:46 scarabeus Exp $

EAPI="2"

KMNAME="kdepim"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Special Dates plugin for Kontact: displays a summary of important holidays and calendar events"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kaddressbook)
	$(add_kdebase_dep korganizer)
	$(add_kdebase_dep kontact)
"

KMEXTRACTONLY="
	kontactinterfaces/
	kaddressbook
	korganizer
"
KMEXTRA="
	kontact/plugins/specialdates/
"

src_prepare() {
	# Fix target_link_libraries for now
	sed -i -e's/korganizer_calendar kaddressbookprivate)/korganizer_calendar)/' \
		kontact/plugins/specialdates/CMakeLists.txt \
		|| die "Failed to remove kaddressbookprivate from link"

	kde4-meta_src_prepare
}
