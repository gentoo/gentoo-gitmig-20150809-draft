# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm_icons/fvwm_icons-1.0.ebuild,v 1.16 2010/02/24 14:52:11 ssuominen Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Icons for use with FVWM"
SRC_URI="http://www.fvwm.org/generated/icon_download/fvwm_icons.tar.bz2"
HOMEPAGE="http://www.fvwm.org/"
IUSE=""
DEPEND="x11-wm/fvwm"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2 FVWM"

src_install () {
	dodir /usr/share/icons/fvwm
	insinto /usr/share/icons/fvwm
	doins "${S}"/*
}
