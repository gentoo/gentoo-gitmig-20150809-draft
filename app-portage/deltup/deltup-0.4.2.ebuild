# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/deltup/deltup-0.4.2.ebuild,v 1.1 2005/03/05 09:30:40 genstef Exp $

inherit eutils

DESCRIPTION="Delta-Update - patch system for updating source-archives."
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND="dev-libs/openssl
	sys-libs/zlib
	>=app-arch/bzip2-1.0.0
	virtual/libc"
RDEPEND="${DEPEND}
	>=dev-util/xdelta-1.1.3"

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README ChangeLog GENTOO
	doman deltup.1
}
