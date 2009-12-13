# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-20071007-r4.ebuild,v 1.3 2009/12/13 09:59:28 abcd Exp $

inherit multilib

DESCRIPTION="Windows 32-bit binary codecs for video and audio playback support"
SRC_URI="mirror://mplayer/releases/codecs/all-${PV}.tar.bz2"
HOMEPAGE="http://www.mplayerhq.hu/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 x86 ~x86-fbsd"
IUSE="real"

RDEPEND="real? ( =virtual/libstdc++-3.3* )"

S="${WORKDIR}/all-${PV}"

RESTRICT="strip binchecks"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Daniel Gryniewicz <dang@gentoo.org>
	has_multilib_profile && ABI="x86"
}

src_install() {
	# see #83221
	insopts -m0644
	dodir /usr/$(get_libdir)/win32

	if use real
	then
		dodir /usr/$(get_libdir)/real
		insinto /usr/$(get_libdir)/real
		doins *so.6.0

		# copy newly introduced codecs from realplayer10
		# see the ChangeLog online
		doins *.so

		# fix bug #80321
		local x
		for x in *so.6.0 *.so; do
			dosym ../real/$x /usr/$(get_libdir)/win32
		done
	fi

	insinto /usr/$(get_libdir)/win32

	doins *.dll *.ax *.xa *.acm *.vwp *.drv *.DLL

	dodoc README

	dodir /etc/revdep-rebuild
	cat - > "${D}/etc/revdep-rebuild/50win32codecs" <<EOF
SEARCH_DIRS_MASK="/usr/$(get_libdir)/real /usr/$(get_libdir)/win32"
EOF
}
