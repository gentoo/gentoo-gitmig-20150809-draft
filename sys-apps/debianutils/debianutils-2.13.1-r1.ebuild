# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/debianutils/debianutils-2.13.1-r1.ebuild,v 1.1 2005/03/24 02:05:54 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="A selection of tools from Debian"
HOMEPAGE="http://packages.debian.org/unstable/base/debianutils.html"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sh ~sparc ~x86"
IUSE="static build"

DEPEND=""

src_compile() {
	use static && append-ldflags -static
	econf || die
	emake || die
}

src_install() {
	into /
	dobin tempfile mktemp || die

	if ! use build ; then
		dobin run-parts || die "run-parts failed"
		dosbin installkernel || die "installkernel failed"

		into /usr
		dosbin savelog mkboot || die "savelog/mkboot failed"

		doman mktemp.1 tempfile.1 run-parts.8 savelog.8 \
			installkernel.8 mkboot.8
		cd debian
		dodoc changelog control
	fi
}
