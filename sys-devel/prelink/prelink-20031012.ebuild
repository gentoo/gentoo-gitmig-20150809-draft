# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/prelink/prelink-20031012.ebuild,v 1.2 2004/02/06 17:57:39 vapier Exp $

inherit eutils

DESCRIPTION="Modifies executables so runtime libraries load faster"
HOMEPAGE="ftp://people.redhat.com/jakub/prelink"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64"

DEPEND=">=dev-libs/elfutils-0.84
	!dev-libs/libelf
	>=sys-libs/glibc-2.3.1
	>=sys-devel/binutils-2.13.90.0.10"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-20030505-glibc231.patch
}

src_compile() {
	econf || die "Configure failed"
	emake || die "Make Failed"
}

src_install() {
	einstall || die "Install Failed"

	dodoc INSTALL TODO ChangeLog THANKS COPYING README AUTHORS NEWS

	insinto /etc
	doins ${S}/doc/prelink.conf
}
