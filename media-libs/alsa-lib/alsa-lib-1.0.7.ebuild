# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-1.0.7.ebuild,v 1.1 2004/11/12 10:58:15 eradicator Exp $

IUSE="static jack"

inherit libtool eutils

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/lib/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86"
LICENSE="GPL-2 LGPL-2.1"

DEPEND="virtual/alsa
	>=media-sound/alsa-headers-${PV}"

PDEPEND="jack? ( =media-plugins/alsa-jack-${PV}* )"

src_unpack() {
	unpack ${A}

	if use static; then
		mv ${S} ${S}.static
		unpack ${A}

		cd ${S}.static
		epatch ${FILESDIR}/${P}-pcm_wait.patch
		elibtoolize
	fi

	cd ${S}
	epatch ${FILESDIR}/${P}-pcm_wait.patch
	elibtoolize
}

src_compile() {
	local myconf=""

	# needed to avoid gcc looping internaly
	use hppa && export CFLAGS="-O1 -pipe"

	econf --enable-static=no --enable-shared=yes || die
	emake || die

	# Can't do both according to alsa docs and bug #48233
	if use static; then
		cd ${S}.static
		econf --enable-static=yes --enable-shared=no || die
		emake || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	preserve_old_lib /usr/$(get_libdir)/libasound.so.1

	dodoc ChangeLog COPYING TODO

	if use static; then
		cd ${S}.static
		make DESTDIR="${D}" install || die "make install failed"
	fi
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libasound.so.1

	einfo "If you are using an emu10k1 based sound card, and you are upgrading"
	einfo "from a version of alsalib <1.0.6, you will need to recompile packages"
	einfo "that link against alsa-lib due to some ABI changes between 1.0.5 and"
	einfo "1.0.6 unique to that hardware. See the following URL for more information:"
	einfo "http://bugs.gentoo.org/show_bug.cgi?id=65347"
}
