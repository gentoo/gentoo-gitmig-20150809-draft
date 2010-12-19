# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-aiptek/xf86-input-aiptek-1.3.1.ebuild,v 1.2 2010/12/19 13:09:31 ssuominen Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="Aiptek USB Digital Tablet Input Driver for Linux"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~sh ~sparc ~x86"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
