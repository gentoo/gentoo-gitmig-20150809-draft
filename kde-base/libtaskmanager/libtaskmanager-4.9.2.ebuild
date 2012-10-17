# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libtaskmanager/libtaskmanager-4.9.2.ebuild,v 1.2 2012/10/17 19:10:20 maekke Exp $

EAPI=4

KMNAME="kde-workspace"
KMMODULE="libs/taskmanager"
inherit kde4-meta

DESCRIPTION="A library that provides basic taskmanager functionality"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kactivities)
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep ksysguard)
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

KMEXTRACTONLY="
	libs/kephal/
	libs/kworkspace/
"

src_prepare() {
	kde4-meta_src_prepare
	sed -e 's:ksysguard/processcore/processes.h:ksysguard/processes.h:g' -i "${S}/libs/taskmanager/taskitem.cpp" || die
	sed -e 's:ksysguard/processcore/process.h:ksysguard/process.h:g' -i "${S}/libs/taskmanager/taskitem.cpp" || die
}
