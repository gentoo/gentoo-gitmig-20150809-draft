# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-2.0_rc3.ebuild,v 1.6 2004/03/17 00:37:16 weeve Exp $

inherit eutils libtool flag-o-matic

DESCRIPTION="The fastest ISO AAC audio decoder available, correctly decodes all MPEG-4 and MPEG-2 MAIN, LOW, LTP, LD and ER object type AAC files"
HOMEPAGE="http://faac.sourceforge.net/"
SRC_URI="mirror://sourceforge/faac/${PN}-${PV/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64"

DEPEND="sys-devel/automake
	>=sys-devel/autoconf-2.58"
#	xmms? ( >=media-sound/xmms-1.2.7
#		media-libs/id3lib )"

RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	# see #34392
	filter-flags -mfpmath=sse

	WANT_AUTOCONF=2.5 WANT_AUTOMAKE=1.7 sh ./bootstrap

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
	einstall || die

	# unneeded include, breaks building of apps
	# <foser@gentoo.org>
	dosed "s:#include <systems.h>::" /usr/include/mpeg4ip.h

	dodoc AUTHORS ChangeLog INSTALL NEWS README README.linux TODO
}
