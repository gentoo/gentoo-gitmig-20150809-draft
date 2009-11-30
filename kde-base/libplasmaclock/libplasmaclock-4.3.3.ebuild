# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libplasmaclock/libplasmaclock-4.3.3.ebuild,v 1.4 2009/11/30 06:55:02 josejx Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="libs/plasmaclock"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Libraries for KDE Plasma's clocks"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86"
IUSE="debug xinerama"

add_blocker plasma-workspace 4.1.50

KMSAVELIBS="true"
