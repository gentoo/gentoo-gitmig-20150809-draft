# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-2.0-r13.ebuild,v 1.5 2007/01/06 16:09:30 redhatter Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils libtool flag-o-matic autotools

PATCHLEVEL="5"

DESCRIPTION="AAC audio decoding library"
HOMEPAGE="http://www.audiocoding.com/"
SRC_URI="mirror://sourceforge/faac/${PN}-${PV/_/-}.tar.gz
	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/libmp4v2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/patches"
	eautoreconf
}

src_compile() {
	# see #34392
	filter-flags -mfpmath=sse

	append-flags -fno-strict-aliasing

	# mp4v2 needed for rhythmbox
	# drm needed for nothing but doesn't hurt
	econf \
		--with-drm \
		--without-xmms \
		|| die "econf failed"

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README README.linux TODO

	# unneeded include, <systems.h> breaks building of apps, but
	# it is necessary because includes <sys/types.h>,
	# which is needed by /usr/include/mp4.h... so we just
	# include <sys/types.h> instead.  See bug #55767
	sed -i -e "s:#include <systems.h>:#include <sys/types.h>:" \
		${D}/usr/include/mpeg4ip.h
	sed -i -e "s:\"mp4ff_int_types.h\":<stdint.h>:" \
		${D}/usr/include/mp4ff.h
}
