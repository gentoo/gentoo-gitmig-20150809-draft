# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-driver/alsa-driver-1.0.1.ebuild,v 1.4 2004/02/08 09:53:07 eradicator Exp $

DESCRIPTION="Advanced Linux Sound Architecture kernel modules"
HOMEPAGE="http://www.alsa-project.org/"
LICENSE="GPL-2 LGPL-2.1"

# By default, drivers for all supported cards will be compiled.
# If you want to only compile for specific card(s), set ALSA_CARDS
# environment to a space-separated list of drivers that you want to build.
# For example:
#
#   env ALSA_CARDS='emu10k1 intel8x0 ens1370' emerge alsa-driver
#
[ x"${ALSA_CARDS}" = x ] && ALSA_CARDS=all

IUSE="oss"

# Need the baselayout 1.7.9 or newer for the init script to work correctly.
DEPEND="sys-devel/autoconf
	virtual/glibc
	virtual/linux-sources
	>=sys-apps/portage-1.9.10
	>=sys-apps/baselayout-1.7.9"
PROVIDE="virtual/alsa"

SLOT="${KV}"
KEYWORDS="~x86 ~ppc -sparc ~amd64 alpha ia64"

MY_P=${P/_rc/rc}
#SRC_URI="ftp://ftp.alsa-project.org/pub/driver/${MY_P}.tar.bz2"
SRC_URI="mirror://alsaproject/driver/${P}.tar.bz2"
RESTRICT="nomirror"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	ewarn "This does not work with kernel 2.6 !!!"
	ewarn "Please use the kernel modules instead of this the package"
	# The makefile still installs an alsasound initscript,
	# which we REALLY dont want.
	# This patch stops that
	epatch ${FILESDIR}/makefile.patch || die "Makefile patch failed"
	epatch ${FILESDIR}/${PN}-0.9.8-au-fix.patch
}


src_compile() {
	# Portage should determine the version of the kernel sources
	check_KV

	myconf=""
	use oss && myconf="$myconf --with-oss=yes" || \
		myconf="$myconf --with-oss=no"

	./configure \
		$myconf \
		--host=${CHOST} \
		--prefix=/usr \
		--with-kernel="${ROOT}usr/src/linux" \
		--with-isapnp=yes \
		--with-sequencer=yes \
		--with-cards="${ALSA_CARDS}" \
		|| die "./configure failed"

	emake || die "Parallel Make Failed"
}


src_install() {
	dodir /usr/include/sound
	make DESTDIR=${D} install || die

	rm doc/Makefile
	dodoc CARDS-STATUS COPYING FAQ INSTALL README WARNING TODO doc/*
}

pkg_postinst() {
	if [ "${ROOT}" = / ]
	then
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi

	einfo
	einfo "The alsasound initscript and modules.d/alsa have now moved to alsa-utils"
	einfo
	einfo "Also, remember that all mixer channels will be MUTED by default."
	einfo "Use the 'alsamixer' program to unmute them."
	einfo
}
