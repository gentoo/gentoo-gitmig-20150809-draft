# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lockfile-progs/lockfile-progs-0.1.15.ebuild,v 1.1 2010/07/07 09:43:53 phajdan.jr Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Programs to safely lock/unlock files and mailboxes"
HOMEPAGE="http://packages.debian.org/sid/lockfile-progs"
SRC_URI="mirror://debian/pool/main/l/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="net-libs/liblockfile"
RDEPEND="${DEPEND}"

S="${WORKDIR}/sid"

src_prepare() {
	# Provide better Makefile, with clear separation between compilation
	# and installation.
	cp "${FILESDIR}/Makefile" . || die "cp failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
