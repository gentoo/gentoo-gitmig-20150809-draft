# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-2.5.ebuild,v 1.2 2006/11/29 11:22:30 chainsaw Exp $

inherit eutils libtool flag-o-matic

DESCRIPTION="AAC audio decoding library"
HOMEPAGE="http://www.audiocoding.com/"
SRC_URI="mirror://sourceforge/faac/${PN}-${PV/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="!media-video/mpeg4ip"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.7
	sys-devel/automake
	sys-devel/autoconf"

S=${WORKDIR}/${PN}

DOCS="AUTHORS ChangeLog INSTALL NEWS README README.linux TODO"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-no-xmms-or-bmp.patch
	epatch ${FILESDIR}/${P}-missing-include.patch
}

src_compile() {
	# see #34392
	filter-flags -mfpmath=sse

	# Fix for bug #67510
	ebegin "Rebuilding configure scripts (this will take a while)"
	WANT_AUTOCONF=2.5 WANT_AUTOMAKE=1.7  \
		aclocal -I . &> /dev/null && \
		autoheader &> /dev/null && \
		libtoolize --automake --copy &> /dev/null && \
		automake --add-missing --copy &> /dev/null && \
		autoconf &> /dev/null || die "Couldn't build configuration file"
	eend $?
	elibtoolize

	# mp4v2 needed for rhythmbox
	# drm needed for nothing but doesn't hurt

	econf \
		--with-mp4v2 \
		--with-drm \
		|| die

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
