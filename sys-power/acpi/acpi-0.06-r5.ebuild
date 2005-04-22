# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpi/acpi-0.06-r5.ebuild,v 1.1 2005/04/22 18:19:12 genstef Exp $

inherit eutils

SRC_URI_BASE="http://ftp.debian.org/debian/pool/main/${PN:0:1}/${PN}"
SRC_URI_TGZ="${PN}_${PV}.orig.tar.gz"
SRC_URI_PATCH="${PN}_${PV}-${PR/r}.diff.gz"
DESCRIPTION="Attempts to replicate the functionality of the 'old' apm command on ACPI systems, including battery and thermal information."
HOMEPAGE="http://packages.debian.org/unstable/utils/acpi.html"
SRC_URI="${SRC_URI_BASE}/${SRC_URI_TGZ} ${SRC_URI_BASE}/${SRC_URI_PATCH}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86 ~amd64"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-apps/help2man
	sys-devel/gcc"

src_unpack() {
	unpack ${SRC_URI_TGZ}
	mv ${PN} ${P}
	epatch ${DISTDIR}/${SRC_URI_PATCH}
}

src_compile() {
	econf || die
	emake || die
	# build docs
	emake -C doc || die
}

src_install() {
	einstall || die
	doman doc/acpi.1
	dodoc AUTHORS CREDITS ChangeLog README
}
