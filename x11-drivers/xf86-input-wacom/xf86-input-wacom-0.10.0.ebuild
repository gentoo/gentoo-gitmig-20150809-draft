# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-wacom/xf86-input-wacom-0.10.0.ebuild,v 1.2 2009/11/05 12:11:19 remi Exp $

inherit x-modular

DESCRIPTION="Driver for Wacom tablets and drawing devices"
LICENSE="GPL-2"
EGIT_REPO_URI="git://anongit.freedesktop.org/~whot/xf86-input-wacom"
[[ ${PV} != 9999* ]] && \
	SRC_URI="http://people.freedesktop.org/~whot/${PN}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.6"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/xproto"
