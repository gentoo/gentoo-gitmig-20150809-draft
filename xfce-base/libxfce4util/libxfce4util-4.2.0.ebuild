# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4util/libxfce4util-4.2.0.ebuild,v 1.10 2005/06/15 07:28:44 corsair Exp $

DESCRIPTION="Libraries for Xfce 4"
LICENSE="LGPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="doc"

BZIPPED=1
RDEPEND="doc? ( dev-util/gtk-doc )"
XFCE_CONFIG="`use_enable doc gtk-doc`"

inherit xfce4
