# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/prelink/prelink-20040707.ebuild,v 1.6 2004/10/24 00:40:28 cretin Exp $

inherit eutils

DESCRIPTION="Modifies executables so runtime libraries load faster"
HOMEPAGE="ftp://people.redhat.com/jakub/prelink"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc ~alpha"
IUSE=""

DEPEND=">=dev-libs/elfutils-0.94
	!dev-libs/libelf
	>=sys-libs/glibc-2.3.2-r9
	>=sys-devel/binutils-2.13.90.0.10"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-init.patch
	echo -e \
	"PRELINK_PATH_MASK=/usr/lib/wine:/usr/lib/valgrind\nPRELINK_PATH=\"\"" \
	> ${S}/60prelink
}

src_compile() {
	econf || die "Configure failed"
	emake || die "Make Failed"
}

src_install() {
	einstall || die "Install Failed"

	dodoc INSTALL TODO ChangeLog THANKS COPYING README AUTHORS NEWS

	insinto /etc/env.d
	doins ${S}/60prelink
}

pkg_postinst() {
	env-update
}
