# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-omapfb/xf86-video-omapfb-0.1.1_p3.ebuild,v 1.1 2010/12/08 13:29:58 armin76 Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

MY_P="${P/_p*//}"

SRC_URI="mirror://debian/pool/main/x/${PN}/${PN}_${PV/_p/-}.tar.gz"
HOMEPAGE="http://gitweb.pingu.fi/?p=xf86-video-omapfb.git;a=tree"

DESCRIPTION="X.org driver for TI OMAP framebuffers"
KEYWORDS="-* ~arm"
IUSE=""
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xproto"

S="${WORKDIR}/${MY_P}"

