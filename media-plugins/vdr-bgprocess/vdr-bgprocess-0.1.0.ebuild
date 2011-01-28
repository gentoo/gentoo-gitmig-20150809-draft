# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-bgprocess/vdr-bgprocess-0.1.0.ebuild,v 1.2 2011/01/28 17:28:43 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Collect information about background process status"
HOMEPAGE="http://linuxtv.org/pipermail/vdr/2008-July/017245.html"
SRC_URI="http://www.reelbox.org/software/vdr/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0"

PATCHES=("${FILESDIR}/${P}-fix-i18n.diff")
