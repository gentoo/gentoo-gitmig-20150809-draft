# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/dclibc/dclibc-0.1.1_beta1.ebuild,v 1.2 2007/12/04 20:13:52 armin76 Exp $

inherit versionator

DESCRIPTION="library for creating a direct connect client"
HOMEPAGE="http://www.gtkdc.org/"

MY_PV=$(replace_version_separator 3 '-')
MY_PV=${MY_PV/beta/debug}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

SRC_URI="http://www.gtkdc.org/gtkdc_files/dclibc/0.1/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
