# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/prelink/prelink-20021002.ebuild,v 1.2 2002/11/15 15:19:33 cretin Exp $

IUSE=""

DESCRIPTION="Modifies executables so runtime libraries load faster"

HOMEPAGE="ftp://people.redhat.com/jakub/prelink"

SRC_URI="ftp://people.redhat.com/jakub/prelink/${P}.tar.bz2"

LICENSE="GPL2"

SLOT="0"

KEYWORDS="x86 sparc sparc64 ppc alpha"

DEPEND=">=dev-libs/libelf-0.8
		>=sys-libs/glibc-2.3.1
		>=sys-devel/binutils-2.13.90.0.10"

S="${WORKDIR}/prelink"

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
