# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/smbkit/smbkit-0.0.1.20060324.ebuild,v 1.2 2007/08/22 16:50:57 angelos Exp $

inherit gnustep

DESCRIPTION="SMBKit offers a samba library and headers for GNUstep."
HOMEPAGE="http://www.gnustep.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc x86"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	net-fs/samba"
RDEPEND="${GS_RDEPEND}
	net-fs/samba"

S="${WORKDIR}/${PN}"

egnustep_install_domain "System"
