# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg3/libmpeg3-1.5.2.ebuild,v 1.16 2004/11/22 22:41:09 vapier Exp $

inherit flag-o-matic eutils gcc

DESCRIPTION="An mpeg library for linux"
HOMEPAGE="http://heroinewarrior.com/libmpeg3.php3"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="sys-libs/zlib
	media-libs/jpeg
	media-libs/a52dec"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# The Makefile is patched to install the header files as well.
	# This patch was generated using the info in the src.rpm that
	# SourceForge provides for this package.
	epatch ${FILESDIR}/${PV}-gentoo-p1.patch
	# Add in support for mpeg3split
	epatch ${FILESDIR}/${PV}-gentoo-mpeg3split.patch
	epatch ${FILESDIR}/${PV}-pthread.patch
	epatch ${FILESDIR}/${PV}-largefile.patch
	epatch ${FILESDIR}/${PV}-proper-c.patch
	epatch ${FILESDIR}/${PV}-no-nasm.patch
	epatch ${FILESDIR}/${PV}-gentoo-multilib.patch
	[ "`gcc-version`" == "3.4" ] && epatch ${FILESDIR}/${PV}-gcc3.4.patch #49452
	# remove a52 crap
	echo > Makefile.a52
	rm -rf a52dec-0.7.3/*
	ln -s /usr/include/a52dec a52dec-0.7.3/include
	local libs
	libs=" -la52"
	if ! [ -f "${ROOT}/usr/$(get_libdir)/liba52.so" ]; then
		if grep -q djbfft ${ROOT}/usr/$(get_libdir)/liba52.a; then
			libs="${libs} -ldjbfft"
		fi
	fi
	sed -i "/LIBS = /s:$: -L\${ROOT}usr/$(get_libdir) ${libs}:" Makefile
}

src_compile() {
	filter-flags -fPIC
	filter-flags -fno-common
	[ ${ARCH} = alpha ] && append-flags -fPIC
	[ ${ARCH} = hppa ] && append-flags -fPIC
	[ ${ARCH} = amd64 ] && append-flags -fPIC

	make || die
}

src_install() {
	# This patch patches the .h files that get installed into /usr/include
	# to show the correct include syntax '<>' instead of '""'  This patch
	# was also generated using info from SF's src.rpm
	epatch ${FILESDIR}/${PV}-gentoo-p2.patch
	make DESTDIR="${D}/usr" LIBDIR="$(get_libdir)" install || die
	dohtml -r docs
}
