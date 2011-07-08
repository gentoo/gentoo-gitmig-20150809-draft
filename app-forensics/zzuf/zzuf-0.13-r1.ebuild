# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/zzuf/zzuf-0.13-r1.ebuild,v 1.2 2011/07/08 10:04:09 ssuominen Exp $

EAPI="2"

inherit autotools

DESCRIPTION="Transparent application input fuzzer"
HOMEPAGE="http://libcaca.zoy.org/wiki/zzuf/"
SRC_URI="http://caca.zoy.org/files/${PN}/${P}.tar.gz
	http://dev.gentoo.org/~cardoe/distfiles/${P}-zzcat-zzat-rename.patch.bz2"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i -e '/CFLAGS/d' "${S}"/configure.ac \
		|| die "unable to fix the configure.ac"
	sed -i -e 's:noinst_:check_:' "${S}"/test/Makefile.am \
		|| die "unable to fix unconditional test building"

	epatch "${DISTDIR}"/${P}-zzcat-zzat-rename.patch.bz2

	eautoreconf
}

src_configure() {
	# Don't build the static library, as the library is only used for
	# preloading, so there is no reason to build it statically, unless
	# you want to use zzuf with a static-linked executable, which I'm
	# not even sure would be a good idea.
	econf \
		--disable-dependency-tracking \
		--disable-static \
		|| die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

# This could be removed in next versions if my patches will be applied
# by Sam. -- Diego 'Flameeyes'
src_test() {
	if has sandbox ${FEATURES}; then
		ewarn "zzuf tests don't work correctly when sandbox is enabled,"
		ewarn "skipping tests. If you want to run the testsuite, please"
		ewarn "disable sandbox for this build."
		return
	fi

	cd "${S}"/test
	emake check || die "Unable to build tools needed for testsuite"

	./testsuite.sh || die "testsuite failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	find "${D}" -name '*.la' -delete
}
