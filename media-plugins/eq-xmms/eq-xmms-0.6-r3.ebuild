# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/eq-xmms/eq-xmms-0.6-r3.ebuild,v 1.1 2005/07/03 08:55:11 voxus Exp $

IUSE="sse-filters"

inherit eutils

DESCRIPTION="EQU is a realtime graphical equalizer effect plugin that will equalize almost everything that you play through XMMS, not just the MP3s"
HOMEPAGE="http://equ.sourceforge.net/"
SRC_URI="mirror://sourceforge/equ/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"

RDEPEND="media-sound/xmms"
DEPEND="${RDEPEND}
	!x86? ( >=sys-devel/automake-1.7 )"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-shade_fix.patch
	epatch ${FILESDIR}/${P}-mono_fix.patch

	if ! use x86 || use sse-filters; then
		cd ${S}

		use sse-filters && {
			epatch ${FILESDIR}/${P}-sse_filters.patch.bz2

			use x86 || {
				epatch ${FILESDIR}/${P}-sse_round_trickfilters.patch
			}
		}

		use x86 || {
			epatch ${FILESDIR}/${P}-nonx86.patch
		}

		ebegin "Performing auto-magic"
		eindent
			ebegin "aclocal"
			WANT_AUTOMAKE=1.7 aclocal
			eend ${?}

			ebegin "automake"
			WANT_AUTOMAKE=1.7 automake
			eend ${?}

			ebegin "autoconf"
			WANT_AUTOCONF=2.5 autoconf
			eend ${?}

			ebegin "libtoolize"
			libtoolize --copy --force
			eend ${?}
		eoutdent
		eend ${?}

		use sse-filters && {
			sed -e "s:@CFLAGS@:@CFLAGS@ -DSSE_FILTERS:" -i ${S}/src/Makefile.in
		}
	fi
}

src_install() {
	make DESTDIR="${D}" libdir=`xmms-config --effect-plugin-dir` install || die

	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README README.BSD SKINS TODO
}
