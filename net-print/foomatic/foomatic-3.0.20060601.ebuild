# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic/foomatic-3.0.20060601.ebuild,v 1.10 2006/12/03 19:07:54 dertobi123 Exp $

inherit versionator

DESCRIPTION="The Foomatic printing meta package"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="foomaticdb ppds"

DEPEND=">=net-print/foomatic-filters-${PV}
	foomaticdb? (
		>=net-print/foomatic-db-engine-${PV}
		>=net-print/foomatic-db-$(get_version_component_range 3)
	)
	ppds? (
		>=net-print/foomatic-db-ppds-$(get_version_component_range 3)
		>=net-print/foomatic-filters-ppds-$(get_version_component_range 3)
	)"
