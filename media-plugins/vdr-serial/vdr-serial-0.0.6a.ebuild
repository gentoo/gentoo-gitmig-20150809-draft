# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-serial/vdr-serial-0.0.6a.ebuild,v 1.1 2006/03/05 11:17:30 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: attach some buttons with diodes to the serial port"
HOMEPAGE="http://www.lf-klueber.de/vdr.htm"
SRC_URI="http://www.lf-klueber.de/vdr-${VDRPLUGIN}-${PV}.tgz
		mirror://vdrfiles/${PN}/vdr-${VDRPLUGIN}-${PV}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6"
