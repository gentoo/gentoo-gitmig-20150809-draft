# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkworkspace/libkworkspace-4.5.4.ebuild,v 1.1 2010/12/02 21:17:31 alexxy Exp $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="libs/kworkspace"
inherit kde4-meta

DESCRIPTION="A library for KDE desktop applications"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
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
