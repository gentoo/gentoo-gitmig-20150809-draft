# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dpkg/dpkg-1.10.18.ebuild,v 1.2 2004/01/24 23:49:03 bazik Exp $

inherit eutils

DESCRIPTION="Package maintenance system for Debian"
HOMEPAGE="http://packages.qa.debian.org/dpkg"
SRC_URI="mirror://debian/pool/main/d/dpkg/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc sparc"

RDEPEND=">=dev-lang/perl-5.6.0
	>=sys-libs/ncurses-5.2-r7
	>=sys-libs/zlib-1.1.4" #app-text/sgmltools-lite?
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5"

src_compile() {
	cd main
	ln -s ../archtable
	cd ..
	epatch ${FILESDIR}/${PN}-${PV}.patch
	./configure || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	rm -f ${D}/usr/sbin/install-info
	dodir /etc/alternatives
	insinto /etc/alternatives
	doins scripts/README.alternatives
	dodoc ABOUT-NLS COPYING ChangeLog INSTALL THANKS TODO
}
