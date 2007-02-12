# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pprocm/pprocm-0.9_beta2.ebuild,v 1.1 2007/02/12 16:51:52 mcummings Exp $

MY_P="PProcM-"${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="PProcM is a Curses App which monitors the system\'s CPU/Disk/Network/Memory usage.  Very small and lightweight"
HOMEPAGE="http://www.fusedcreations.com/PProcM/"
SRC_URI="http://www.fusedcreations.com/PProcM/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/POE
	dev-perl/Sys-Statistics-Linux
	dev-lang/perl"

src_install() {
	dobin PProcM || die "dobin failed"
	dodoc AUTHORS README || die "dodoc failed"
}
