# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/prelink/prelink-20021002-r1.ebuild,v 1.7 2003/04/14 09:49:39 cretin Exp $

IUSE=""

inherit eutils

S=${WORKDIR}/${PN}
DESCRIPTION="Modifies executables so runtime libraries load faster"
SRC_URI="ftp://people.redhat.com/jakub/prelink/${P}.tar.bz2"
HOMEPAGE="ftp://people.redhat.com/jakub/prelink"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha"

DEPEND=">=dev-libs/libelf-0.8
	>=sys-libs/glibc-2.3.1
	>=sys-devel/binutils-2.13.90.0.10"


src_unpack() {
	unpack ${A}

	cd ${S}; epatch ${FILESDIR}/${PN}-no-undosyslibs-test.patch
	epatch ${FILESDIR}/${P}-copyreloc.patch
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

