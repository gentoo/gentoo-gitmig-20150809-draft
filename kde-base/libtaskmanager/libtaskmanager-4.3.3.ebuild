# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libtaskmanager/libtaskmanager-4.3.3.ebuild,v 1.4 2009/11/30 06:55:06 josejx Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="libs/taskmanager"
inherit kde4-meta

DESCRIPTION="A library that provides basic taskmanager functionality"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kephal)
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"
