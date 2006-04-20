# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg3/libmpeg3-1.5.2-r3.ebuild,v 1.1 2006/04/20 03:35:22 flameeyes Exp $

inherit flag-o-matic eutils toolchain-funcs

PATCHLEVEL="3"
DESCRIPTION="An mpeg library for linux"
HOMEPAGE="http://heroinewarrior.com/libmpeg3.php3"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2
	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="mmx"

RDEPEND="sys-libs/zlib
	media-libs/jpeg
	media-libs/a52dec"
DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# The Makefile is patched to install the header files as well.
	# This patch was generated using the info in the src.rpm that
	# SourceForge provides for this package.
	[ "`gcc-version`" == "3.4" -o "`gcc-major-version`" -ge 4 ] || \
		EPATCH_EXCLUDE="${EPATCH_EXCLUDE} 08_all_gcc34.patch"
	[ "`gcc-major-version`" -ge 4 ] || \
		EPATCH_EXCLUDE="${EPATCH_EXCLUDE} 09_all_gcc4.patch"

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/${PV}

	sed -i -e "/LIBS = /s:$: -L\${ROOT}usr/$(get_libdir) -la52:" Makefile

	epatch "${FILESDIR}/${P}-a52.patch"

	if ! use mmx || has_pic ; then
		sed -i -e 's:^NASM =.*:NASM =:' \
			-e 's|^HAVE_NASM :=.*|HAVE_NASM=n|' \
			-e 's|USE_MMX = 1|USE_MMX = 0|' \
			Makefile
	fi
}

src_compile() {
	local obj_dir=$(uname --machine)

	mkdir $obj_dir

	rm -f ${obj_dir}/*.o &> /dev/null

	emake CC="$(tc-getCC)" || die "make failed"
}

src_install() {
	# This patch patches the .h files that get installed into /usr/include
	# to show the correct include syntax '<>' instead of '""'  This patch
	# was also generated using info from SF's src.rpm
	epatch ${WORKDIR}/${PV}/gentoo-p2.patch
	make DESTDIR="${D}/usr" LIBDIR="$(get_libdir)" install || die
	dohtml -r docs
}
