# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dummydevice/vdr-dummydevice-0.0.1.ebuild,v 1.2 2006/04/24 20:49:05 zzam Exp $

IUSE=""
inherit vdr-plugin

DESCRIPTION="VDR plugin: dummy output device - for recording server without TV"
HOMEPAGE="http://famillejacques.free.fr/vdr/"
SRC_URI="http://users.tkk.fi/~phintuka/vdr/vdr-dummydevice/${P}.tgz"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"

