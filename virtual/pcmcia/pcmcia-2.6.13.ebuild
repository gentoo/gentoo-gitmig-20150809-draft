# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/pcmcia/pcmcia-2.6.13.ebuild,v 1.2 2006/02/16 02:35:26 vapier Exp $

DESCRIPTION="Virtual for PCMCIA userspace tools"
HOMEPAGE="http://www.gentoo.org/proj/en/base/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ppc sh x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( sys-apps/pcmcia-cs sys-apps/pcmciautils )"
