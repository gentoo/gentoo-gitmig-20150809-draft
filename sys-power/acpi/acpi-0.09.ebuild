# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpi/acpi-0.09.ebuild,v 1.2 2006/08/20 04:03:53 vapier Exp $

inherit eutils

DESCRIPTION="Attempts to replicate the functionality of the 'old' apm command on ACPI systems, including battery and thermal information."
HOMEPAGE="http://grahame.angrygoats.net/acpi.shtml"
SRC_URI="http://grahame.angrygoats.net/source/acpi/${P}.tar.gz
	mirror://debian/pool/main/a/acpi/${P/-/_}-1.diff.gz"
# debian diff only for the manpage

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	doman acpi.1

	cd "${WORKDIR}"
	epatch ${P/-/_}-1.diff
}
