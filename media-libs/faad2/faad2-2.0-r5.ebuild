# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-2.0-r5.ebuild,v 1.1 2005/03/25 23:52:56 luckyduck Exp $

inherit eutils libtool flag-o-matic

DESCRIPTION="AAC audio decoding library"
HOMEPAGE="http://www.audiocoding.com/"
SRC_URI="mirror://sourceforge/faac/${PN}-${PV/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~sparc"
IUSE="xmms"

RDEPEND="xmms? ( >=media-sound/xmms-1.2.7
		media-libs/id3lib )
	!media-video/mpeg4ip"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.7
	sys-devel/automake
	sys-devel/autoconf"

S=${WORKDIR}/${PN}

DOCS="AUTHORS ChangeLog INSTALL NEWS README README.linux TODO"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-makefile-space.patch
	epatch ${FILESDIR}/${P}-configure-mpeg4ip.patch
	epatch ${FILESDIR}/${P}-gcc34.patch

	# merged version of the noext and amd64 patch, see #61528
	epatch ${FILESDIR}/${P}-amd64_noext.patch

	cd ${S}/common/mp4v2
	epatch ${FILESDIR}/mp4atom-sliver.patch

	# Get the xmms plugin to behave
	cd ${S}
	elibtoolize

}

src_compile() {

	# see #34392
	filter-flags -mfpmath=sse

	# Fix for bug #67510
	WANT_AUTOCONF=2.5 WANT_AUTOMAKE=1.7  \
		aclocal -I . && \
		autoheader && \
		libtoolize --automake --copy	&& \
		automake --add-missing --copy	&& \
		autoconf || die "Couldn't build configuration file"

	# mp4v2 needed for rhythmbox
	# drm needed for nothing but doesn't hurt

	econf \
		--with-mp4v2 \
		--with-drm \
		`use_with xmms` \
		|| die

	# emake causes xmms plugin building to fail
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc ${DOCS}

	# unneeded include, <systems.h> breaks building of apps, but
	# it is necessary because includes <sys/types.h>,
	# which is needed by /usr/include/mp4.h... so we just
	# include <sys/types.h> instead.  See bug #55767
	dosed "s:#include <systems.h>:#include <sys/types.h>:" /usr/include/mpeg4ip.h
	# make latexer happy
	dosed "s:\"mp4ff_int_types.h\":<stdint.h>:" /usr/include/mp4ff.h

}
