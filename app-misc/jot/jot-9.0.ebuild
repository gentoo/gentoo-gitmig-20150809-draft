# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jot/jot-9.0.ebuild,v 1.1 2003/04/22 21:11:33 avenj Exp $

DESCRIPTION="Print out increasing, decreasing, random, or redundant data"
HOMEPAGE="http://freshmeat.net/projects/bsd-jot/"
SRC_URI="http://www.mit.edu/afs/athena/system/rhlinux/athena-9.0/free/SRPMS/athena-jot-9.0-3.src.rpm"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="rpm2targz"
RDEPEND=""
S="${WORKDIR}/athena-jot-9.0"

src_unpack() {
	cd ${WORKDIR}
	rpm2targz ${DISTDIR}/${A}
	tar xzf athena-jot-9.0-3.src.tar.gz
	tar xzf athena-jot-9.0.tar.gz
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
