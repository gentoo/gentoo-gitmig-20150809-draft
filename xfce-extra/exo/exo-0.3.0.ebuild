# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/exo/exo-0.3.0.ebuild,v 1.7 2005/12/10 03:22:46 dostrow Exp $

DESCRIPTION="Extension library for Xfce"
HOMEPAGE="http://www.os-cillation.com/"
KEYWORDS="~amd64 arm ia64 ppc ppc64 ~sparc x86"

RDEPEND=">=x11-libs/gtk+-2.4
	>=xfce-base/libxfce4mcs-4.2.0"
BZIPPED=1
GOODIES=1

inherit xfce4
