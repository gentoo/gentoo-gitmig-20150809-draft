# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg3/libmpeg3-1.5.2.ebuild,v 1.10 2004/07/29 02:59:44 tgall Exp $

inherit flag-o-matic eutils gcc

DESCRIPTION="An mpeg library for linux"
HOMEPAGE="http://heroinewarrior.com/libmpeg3.php3"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ppc64"
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
	[ "`gcc-version`" == "3.4" ] && epatch ${FILESDIR}/${PV}-gcc3.4.patch #49452
	# remove a52 crap
	echo > Makefile.a52
	rm -rf a52dec-0.7.3/*
	ln -s /usr/include/a52dec a52dec-0.7.3/include
	sed -i '/LIBS = /s:$: -la52:' Makefile
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
	make DESTDIR=${D}/usr install || die
	dohtml -r docs
}
