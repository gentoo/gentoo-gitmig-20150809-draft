# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dash/dash-0.5.1.1.ebuild,v 1.3 2004/09/21 09:48:01 ka0ttic Exp $

inherit eutils

IUSE=""

MY_P=${P%.*}
MY_P2=${MY_P/-/_}
DEB_P=${PN}_${PV%.*}-${PV##*.}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Debian-version of NetBSD's lightweight bourne shell"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/d/dash/"
SRC_URI="mirror://debian/pool/main/d/dash/${MY_P2}.orig.tar.gz \
	mirror://debian/pool/main/d/dash/${DEB_P}.diff.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc"

DEPEND="sys-apps/sed
	dev-util/yacc"

src_compile() {
	epatch ${WORKDIR}/${DEB_P}.diff
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	exeinto /bin
	newexe src/dash dash

	newman src/dash.1 dash.1

	dodoc COPYING debian/changelog
}
