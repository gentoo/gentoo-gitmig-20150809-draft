# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/prelink/prelink-20021213.ebuild,v 1.6 2003/04/14 08:28:17 cretin Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/${PN}"
DESCRIPTION="Modifies executables so runtime libraries load faster"
SRC_URI="ftp://people.redhat.com/jakub/prelink/${P}.tar.bz2 mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="ftp://people.redhat.com/jakub/prelink"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc alpha"

DEPEND=">=dev-libs/elfutils-0.72
	!dev-libs/libelf
	>=sys-libs/glibc-2.3.1
	>=sys-devel/binutils-2.13.90.0.10"


src_unpack() {
	unpack ${A}

	cd ${S}; epatch ${FILESDIR}/${P}-no-undosyslibs-test.patch
}

src_compile() {

	econf || die "Configure failed"

	emake || die "Make Failed"

	LD_PRELOAD_SAVE=${LD_PRELOAD}
	unset LD_PRELOAD
	make check || die "make check failed"
	export LD_PRELOAD=${LD_PRELOAD_SAVE}
}

src_install() {
	einstall || die "Install Failed"

	dodoc INSTALL TODO ChangeLog THANKS COPYING README AUTHORS NEWS

	insinto /etc
	doins ${S}/doc/prelink.conf
}

