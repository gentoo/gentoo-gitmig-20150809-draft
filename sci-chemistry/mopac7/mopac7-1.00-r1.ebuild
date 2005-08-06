# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mopac7/mopac7-1.00-r1.ebuild,v 1.2 2005/08/06 09:09:24 dholm Exp $

inherit flag-o-matic

DESCRIPTION="Autotooled, updated version of a powerful, fast semi-empirical package"
HOMEPAGE="http://sourceforge.net/projects/mopac7/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="mopac7"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
DEPEND="dev-libs/libf2c
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"
RDEPEND="dev-libs/libf2c"

src_compile() {
	libtoolize --copy --force

	# This is absolutely required to avoid odd errors on MAIN__() not existing
	# and to build the mopac7 binary, not just the library.
	einfo "Adding required LDFLAGS for configure"
	econf LDFLAGS="-Xlinker -defsym -Xlinker MAIN__=main" || die "econf failed"

	# We need the appended LDFLAGS to activate building of the mopac7 binary,
	# but they break the actual linking of it. Something's obviously broken.
	einfo "Removing LDFLAGS, as they break the build"
	sed -i "/^LDFLAGS/d" src/Makefile.in
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	sed -i "s:./src/mopac7:mopac7:g" run_mopac7
	dobin run_mopac7 src/.libs/mopac7
	dodoc AUTHORS README ChangeLog
}
