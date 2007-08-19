# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg3/libmpeg3-1.7.ebuild,v 1.13 2007/08/19 02:18:14 mr_bones_ Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools toolchain-funcs

PATCHLEVEL="1"
DESCRIPTION="An mpeg library for linux"
HOMEPAGE="http://heroinewarrior.com/libmpeg3.php3"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2
	mirror://gentoo/${P}-gentoo.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="mmx"

RDEPEND="sys-libs/zlib
	media-libs/jpeg
	media-libs/a52dec"
DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if [[ $(gcc-version) == "3.3" ]]; then
		eerror "You're using an old version of GCC, but this package is"
		eerror "designed to work only with GCC 3.4 or later."
		eerror "Please upgrade your GCC or change the selected profile"
		eerror "and then merge this again."
		die "Package won't build with GCC 3.3."
	fi

	epatch "${WORKDIR}/${P}-mpeg3split.patch"
	epatch "${WORKDIR}/${P}-textrel.patch"
	epatch "${WORKDIR}/${P}-gnustack.patch"
	epatch "${WORKDIR}/${P}-a52.patch"
	epatch "${WORKDIR}/${P}-all_gcc4.patch"
	epatch "${WORKDIR}/${P}-all_pthread.patch"

	# warning: incompatible implicit declaration of built-in function memcpy
	epatch "${FILESDIR}"/${P}-memcpy.patch
}

src_compile() {

	cp -rf ${WORKDIR}/${PV}/* .
	eautoreconf

	#disabling css since it's a fake one.
	#One can find in the sources this message :
	#  Stubs for deCSS which can't be distributed in source form

	econf $(use_enable mmx )\
		--disable-css || die "Configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dohtml -r docs
	# This is a workaround, it wants to rebuild
	# everything if the headers	 have changed
	# So we patch them after install...
	cd "${D}/usr/include/libmpeg3"
	# This patch patches the .h files that get installed into /usr/include
	# to show the correct include syntax '<>' instead of '""'  This patch
	# was also generated using info from SF's src.rpm
	epatch "${WORKDIR}/gentoo-p2.patch"
}
