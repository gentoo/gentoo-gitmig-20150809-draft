# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dpkg/dpkg-1.10.10.ebuild,v 1.2 2003/07/29 13:57:33 lanius Exp $

DESCRIPTION="Package maintenance system for Debian"
HOMEPAGE="http://packages.qa.debian.org/dpkg"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SRC_URI="http://ftp.debian.org/debian/pool/main/d/dpkg/dpkg_${PV}.tar.gz"
RDEPEND=">=dev-lang/perl-5.6.0
	>=sys-libs/ncurses-5.2-r7
	>=sys-libs/zlib-1.1.4" #app-text/sgmltools-lite?

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5"

S="${WORKDIR}/dpkg-${PV}"

src_compile() {
	cd main
	ln -s ../archtable
	cd ..
	epatch ${FILESDIR}/${P}.patch
	./configure || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
    dodir /etc/alternatives
	insinto /etc/alternatives
	doins scripts/README.alternatives
	dodoc ABOUT-NLS COPYING ChangeLog INSTALL THANKS TODO
}
