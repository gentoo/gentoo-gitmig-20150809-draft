# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic/foomatic-2.0.0.ebuild,v 1.11 2003/05/19 19:57:02 mholzer Exp $

inherit perl-module

DESCRIPTION="Generates printer configurations automagically"
HOMEPAGE="http://www.linuxprinting.org/foomatic"
SRC_URI="http://www.linuxprinting.org/download/foomatic/oldstuff/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="virtual/glibc
	dev-libs/libxml2
	net-misc/wget
	net-ftp/curl
	samba? ( net-fs/samba )
	cups? ( net-print/cups )"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/perl-module.diff || die "patch failed"
}

src_compile() {
	econf || die "configure failed"

	# Doesn't always build when using emake.  It fails consistently on
	# my Athlon when using -j6.  (22 Jan 2003 agriffis)
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# install perl modules
	cd ${S}/lib
	perl-module_src_prep
	perl-module_src_compile
	perl-module_src_test
	perl-module_src_install

}
