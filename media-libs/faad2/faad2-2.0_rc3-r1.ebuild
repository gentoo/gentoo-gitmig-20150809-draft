# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-2.0_rc3-r1.ebuild,v 1.4 2004/02/17 21:18:18 agriffis Exp $

inherit eutils libtool flag-o-matic

DESCRIPTION="The fastest ISO AAC audio decoder available, correctly decodes all MPEG-4 and MPEG-2 MAIN, LOW, LTP, LD and ER object type AAC files"
HOMEPAGE="http://faac.sourceforge.net/"
SRC_URI="mirror://sourceforge/faac/${PN}-${PV/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 alpha ia64"
IUSE="xmms"

RDEPEND="xmms? ( >=media-sound/xmms-1.2.7
	media-libs/id3lib )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.7
	sys-devel/automake
	sys-devel/autoconf"

S=${WORKDIR}/${PN}

DOCS="AUTHORS ChangeLog INSTALL NEWS README README.linux TODO"

src_compile() {
	# see #34392
	filter-flags -mfpmath=sse

	WANT_AUTOCONF=2.5 WANT_AUTOMAKE=1.7 sh ./bootstrap

	# mp4v2 needed for rhythmbox
	# drm needed for nothing but doesn't hurt

	econf \
		--with-mp4v2 \
		--with-drm \
		`use_with xmms` \
		|| die

	# emake causes xmms plugin building to fail
	make || die
}

src_install() {
	# Copy over the xmms plugins first.  make install will not install these unless this is an upgrade.  See bug #38001
	if use xmms; then
		exeinto `xmms-config --input-plugin-dir`
		doexe ${S}/plugins/xmmsmp4/src/.libs/libmp4.so
		doexe ${S}/plugins/xmms/src/.libs/libaac.so
	fi

	make DESTDIR=${D} install || die

	dodoc ${DOCS}

	# unneeded include, breaks building of apps
	# <foser@gentoo.org>
	dosed "s:#include <systems.h>::" /usr/include/mpeg4ip.h
}
