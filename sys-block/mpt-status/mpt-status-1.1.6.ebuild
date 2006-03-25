# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/mpt-status/mpt-status-1.1.6.ebuild,v 1.1 2006/03/25 19:06:36 nelchael Exp $

inherit eutils

DESCRIPTION="mpt-status is a query tool to access the running configuration and status of LSI SCSI HBAs."
HOMEPAGE="http://www.drugphish.ch/~ratz/mpt-status/"
SRC_URI="http://www.drugphish.ch/~ratz/mpt-status/${P}.tar.bz2
	mirror://gentoo/${P}-linux-sources.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {

	unpack ${A}
	epatch "${FILESDIR}/${P}-gentoo.patch"

}

src_install() {

	make DESTDIR="${D}" install || die "make install failed"
	cd "${S}/doc"
	dodoc AUTHORS Changelog DeveloperNotes FAQ README \
		ReleaseNotes THANKS TODO

}
