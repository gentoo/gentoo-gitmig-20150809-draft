# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/eq-xmms/eq-xmms-0.6-r4.ebuild,v 1.2 2006/01/07 03:14:54 voxus Exp $

IUSE="sse-filters"

inherit eutils autotools

DESCRIPTION="EQU is a realtime graphical equalizer effect plugin that will equalize almost everything that you play through XMMS, not just the MP3s"
HOMEPAGE="http://equ.sourceforge.net/"
SRC_URI="mirror://sourceforge/equ/${P}.tar.gz
http://dev.gentoo.org/~voxus/equ/eq-xmms-0.6-cvs-20051113.patch.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -amd64 ~sparc ~ppc"

RDEPEND="media-sound/xmms"
DEPEND="${RDEPEND}
	!x86? ( >=sys-devel/automake-1.7 )"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-shade_fix.patch
	epatch ${FILESDIR}/${P}-mono_fix.patch

	if ! use x86 || use sse-filters; then
		cd ${S}

		if use sse-filters; then
			epatch ${FILESDIR}/${P}-sse_filters.patch.bz2
			epatch ${FILESDIR}/${P}-sse_round_trickfilters.patch
			epatch ${DISTDIR}/${P}-cvs-20051113.patch.bz2
		fi

		use x86 || epatch ${FILESDIR}/${P}-nonx86.patch

		export WANT_AUTOMAKE="1.7"
		export WANT_AUTOCONF="2.5"
		eautoreconf

		use sse-filters && \
			sed -e "s:@CFLAGS@:@CFLAGS@ -DSSE_FILTERS:" -i ${S}/src/Makefile.in
	fi
}

src_install() {
	make DESTDIR="${D}" libdir=`xmms-config --effect-plugin-dir` install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README README.BSD SKINS TODO
}
