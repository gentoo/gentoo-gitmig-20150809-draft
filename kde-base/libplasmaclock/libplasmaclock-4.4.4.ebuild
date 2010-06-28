# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libplasmaclock/libplasmaclock-4.4.4.ebuild,v 1.4 2010/06/28 03:04:23 fauli Exp $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="libs/plasmaclock"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Libraries for KDE Plasma's clocks"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

KMSAVELIBS="true"
