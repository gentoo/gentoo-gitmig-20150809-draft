# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dpkg/dpkg-1.10.10.ebuild,v 1.3 2003/08/05 14:48:27 vapier Exp $

inherit eutils

DESCRIPTION="Package maintenance system for Debian"
HOMEPAGE="http://packages.qa.debian.org/dpkg"
SRC_URI="http://ftp.debian.org/debian/pool/main/d/dpkg/dpkg_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND=">=dev-lang/perl-5.6.0
	>=sys-libs/ncurses-5.2-r7
	>=sys-libs/zlib-1.1.4" #app-text/sgmltools-lite?
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5"

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
