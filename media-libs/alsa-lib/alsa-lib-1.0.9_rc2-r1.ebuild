# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-1.0.9_rc2-r1.ebuild,v 1.1 2005/04/06 10:29:56 eradicator Exp $

IUSE="jack doc"

inherit eutils

MY_P="${P/_rc/rc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/lib/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="virtual/alsa
	>=media-sound/alsa-headers-${PV}"

DEPEND="${RDEPEND}
	doc? ( >=app-doc/doxygen-1.2.6 )"

PDEPEND="jack? ( =media-plugins/alsa-jack-${PV}* )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc4.patch
	epatch ${FILESDIR}/${P}-87099.patch
}

src_compile() {
	local myconf=""

	# needed to avoid gcc looping internaly
	use hppa && export CFLAGS="-O1 -pipe"

	econf --enable-static --enable-shared || die
	emake || die

	if use doc; then
		emake doc || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc ChangeLog COPYING TODO
	use doc && dohtml -r doc/doxygen/html/*
}

pkg_postinst() {
	einfo "If you are using an emu10k1 based sound card, and you are upgrading"
	einfo "from a version of alsalib <1.0.6, you will need to recompile packages"
	einfo "that link against alsa-lib due to some ABI changes between 1.0.5 and"
	einfo "1.0.6 unique to that hardware. See the following URL for more information:"
	einfo "http://bugs.gentoo.org/show_bug.cgi?id=65347"
	echo
	ewarn "Please use media-sound/alsa-driver rather than in-kernel drivers as there"
	ewarn "have been some problems recently with the in-kernel drivers.  See bug #87544."
}
