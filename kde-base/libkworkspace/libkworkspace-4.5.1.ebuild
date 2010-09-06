# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkworkspace/libkworkspace-4.5.1.ebuild,v 1.1 2010/09/06 01:44:33 tampakrap Exp $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="libs/kworkspace"
inherit kde4-meta

DESCRIPTION="A library for KDE desktop applications"
KEYWORDS=""
IUSE="debug"

# FIXME dependencies until activities API is moved to kdelibs (4.6)
DEPEND="
	>=dev-libs/shared-desktop-ontologies-0.4
	>=dev-libs/soprano-2.4.64[raptor,redland]
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	ksmserver/org.kde.KSMServerInterface.xml
	kwin/org.kde.KWin.xml
"

KMSAVELIBS="true"

src_prepare() {
	sed -i -e 's/install( FILES kdisplaymanager.h/install( FILES kdisplaymanager.h screenpreviewwidget.h/' \
		libs/kworkspace/CMakeLists.txt || die "failed to provide screenpreviewwidget.h"

	kde4-meta_src_prepare
}
