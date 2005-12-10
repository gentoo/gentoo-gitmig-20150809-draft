# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/linuxtv-dvb-headers/linuxtv-dvb-headers-3.1.ebuild,v 1.8 2005/12/10 12:00:03 hansmi Exp $

inherit eutils

DESCRIPTION="Virtual Package installing the Header files for DVB"
HOMEPAGE="http://www.linuxtv.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RDEPEND="|| (
		>=sys-kernel/linux-headers-2.6.11-r2
		media-tv/linuxtv-dvb
	)"
