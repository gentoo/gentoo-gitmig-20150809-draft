# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/pmtools/pmtools-20051111.ebuild,v 1.1 2006/06/02 02:39:40 robbat2 Exp $

inherit libtool eutils

DESCRIPTION="ACPI utilities, including acpidump"
HOMEPAGE="http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/"
SRC_URI="http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~amd64 ~x86"
IUSE=""
DEPEND=""

src_compile() {
	make || die "emake failed"
}

src_install() {
	dosbin acpidump/acpidump acpidump/acpitbl acpidump/acpixtract
	dodoc README
}
