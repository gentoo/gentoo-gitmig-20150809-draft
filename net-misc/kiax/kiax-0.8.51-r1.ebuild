# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kiax/kiax-0.8.51-r1.ebuild,v 1.4 2009/05/30 10:24:28 volkmar Exp $

EAPI="2"

inherit qt3 eutils

DESCRIPTION="QT based IAX (Inter Asterisk eXchange) client"
HOMEPAGE="http://kiax.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/libXpm
	>=x11-libs/qt-3.2:3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-src"

# TODO:
# kiax bundles an old iaxclient version, not easy to fix that
# using ilbc (license issues)

src_prepare() {
	# fix compile with glibc-2.8, see bug #246131
	epatch "${FILESDIR}"/${P}-h_addr_list.patch

	# fix install_qa_check with amd64, see bug 269778
	epatch "${FILESDIR}"/${P}-missing-header.patch

	# add prefix for make install
	sed -i -e "s:\(\$(DEST_PATH)\):\${INSTALL_ROOT}\1:" \
		bin/Makefile || die "patching bin/Makefile failed"

	# fix icon/i18n prefix (bug #123839)
	sed -i -e "s:/usr/local:/usr:g" \
		src/src.pro.or || die "patching src/src.pro.or failed"

	# src/src.pro.or has to be used instead of src/src.pro
	cp src/src.pro.or src/src.pro \
		|| die "copying src/src.pro.or to src/src.pro failed"
}

src_configure() {
	# don't use ./configure script
	./repath.pl --prefix=/usr || die "repath script failed"

	eqmake3 qkiax.pro -o Makefile
	eqmake3 src/src.pro -o src/Makefile
	# lib/lib.pro doesn't exist
	# don't use qmake for bin/ and i18n/, Makefiles already exist
	# and generated ones are not good
}

src_compile() {
	# -j1 for bug 270231
	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/bin
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	dodoc README README.* CHANGELOG || die "dodoc failed"

	domenu kiax.desktop || die "domenu failed"
}
