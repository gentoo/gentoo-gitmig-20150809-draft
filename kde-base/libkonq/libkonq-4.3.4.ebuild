# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkonq/libkonq-4.3.4.ebuild,v 1.3 2009/12/27 15:25:21 armin76 Exp $

EAPI="2"

KMNAME="kdebase-apps"
KMMODULE="lib/konq"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"
RESTRICT="test"

KMSAVELIBS="true"

PATCHES=( "${FILESDIR}/fix_includes_install.patch" )
