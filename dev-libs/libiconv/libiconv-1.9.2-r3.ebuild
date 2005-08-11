# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiconv/libiconv-1.9.2-r3.ebuild,v 1.6 2005/08/11 11:15:34 flameeyes Exp $

inherit eutils multilib flag-o-matic

DESCRIPTION="GNU charset conversion library for libc which doesn't implement it"
SRC_URI="mirror://gnu/libiconv/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libiconv/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="build"

DEPEND="virtual/libc
	!sys-libs/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-RPATH-fix.patch
}

src_compile() {
	# Filter -static as it breaks compilation
	filter-ldflags -static

	# Install in /lib as utils installed in /lib like gnutar
	# can depend on this

	# Disable NLS support because that creates a circular dependency
	# between libiconv and gettext

	econf \
		--disable-nls \
		 || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} docdir="/usr/share/doc/${PF}/html" install || die "make install failed"

	# Move static libs and creates ldscripts into /usr/lib
	dodir /$(get_libdir)
	mv ${D}/usr/$(get_libdir)/*.so* ${D}/$(get_libdir)
	gen_usr_ldscript libiconv.so
	gen_usr_ldscript libcharset.so

	use build && rm -rf ${D}/usr
}
