# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jot/jot-9.0.ebuild,v 1.9 2005/05/10 06:21:18 wormo Exp $

inherit rpm

RH_REV=3
DESCRIPTION="Print out increasing, decreasing, random, or redundant data"
HOMEPAGE="http://freshmeat.net/projects/bsd-jot/"
SRC_URI="http://www.mit.edu/afs/athena/system/rhlinux/athena-${PV}/free/SRPMS/athena-${P}-${RH_REV}.src.rpm"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

S="${WORKDIR}/athena-${P}"

src_install() {
	einstall || die
}
