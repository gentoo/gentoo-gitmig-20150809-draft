# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-2.0_rc3.ebuild,v 1.3 2003/12/30 17:37:03 foser Exp $

inherit eutils libtool flag-o-matic

# see #34392
filter-flags "-mfpmath=sse"

HOMEPAGE="http://faac.sourceforge.net/"
DESCRIPTION="The fastest ISO AAC audio decoder available, correctly decodes all MPEG-4 and MPEG-2 MAIN, LOW, LTP, LD and ER object type AAC files"
LICENSE="GPL-2"

SRC_URI="mirror://sourceforge/faac/${PN}-${PV/_/-}.tar.gz"
IUSE=""
S=${WORKDIR}/${PN}

KEYWORDS="x86 ~ppc ~sparc ~amd64"

DEPEND="virtual/glibc
	sys-devel/automake
	sys-devel/autoconf"

#	xmms? ( >=media-sound/xmms-1.2.7
#		media-libs/id3lib )"

SLOT="0"

src_compile() {

	WANT_AUTOCONF_2_5=1 WANT_AUTOMAKE=1.7 sh ./bootstrap

	# mp4v2 needed for rhythmbox
	# drm needed for nothing but doesn't hurt
	# xmms disabled, needs some makefile fixing
	econf \
		--with-mp4v2 \
		--with-drm \
		--without-xmms \
		|| die

	emake || die

}

src_install() {

	einstall

	# unneeded include, breaks building of apps
	# <foser@gentoo.org>
	dosed "s:#include <systems.h>::" /usr/include/mpeg4ip.h

	dodoc AUTHORS ChangeLog INSTALL NEWS README README.linux TODO

}
