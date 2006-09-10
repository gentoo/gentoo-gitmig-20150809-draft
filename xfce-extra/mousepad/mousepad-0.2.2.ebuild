# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/mousepad/mousepad-0.2.2.ebuild,v 1.6 2006/09/10 04:16:31 vapier Exp $

DESCRIPTION="Small text editor for Xfce 4"
SRC_URI="http://erikharrison.net/software/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 arm ~hppa ia64 ~mips ~ppc ppc64 ~sparc x86"

RDEPEND="xfce-base/libxfce4mcs"

inherit xfce4
