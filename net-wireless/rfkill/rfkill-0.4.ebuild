# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rfkill/rfkill-0.4.ebuild,v 1.3 2010/10/07 10:19:16 phajdan.jr Exp $

inherit toolchain-funcs

DESCRIPTION="Tool to read and control rfkill status through /dev/rfkill"
HOMEPAGE="http://wireless.kernel.org/en/users/Documentation/rfkill"
SRC_URI="http://wireless.kernel.org/download/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/make"

CC=$(tc-getCC)
LD=$(tc-getLD)

src_compile() {
	emake || die "Failed to compile"
}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
}
