# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/emovix/emovix-0.9.0_pre1.ebuild,v 1.1 2004/07/27 07:51:36 chriswhite Exp $

MY_P="${P/_/}"

DESCRIPTION="Micro Linux distro to boot from a CD and play every video file localized in the CD root."
HOMEPAGE="http://movix.sourceforge.net/"
CODEC_URI="http://www1.mplayerhq.hu/MPlayer/releases/codecs/"
SRC_URI="mirror://sourceforge/movix/${MY_P}.tar.gz
			codecs? ( ${CODEC_URI}qt63dlls-20040626.tar.bz2
					${CODEC_URI}rp9codecs-20040626.tar.bz2
					${CODEC_URI}rp9codecs-win32-20040626.tar.bz2
					${CODEC_URI}win32codecs-20040703.tar.bz2
					${CODEC_URI}xanimdlls-20040626.tar.bz2 )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="codecs"
DEPEND=">=dev-lang/perl-5.0
		sys-apps/gawk
		app-cdr/cdrtools"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL README* TODO
	if use codecs
	then
		insinto /usr/share/emovix/codecs
		insopts -m622
		doins ${DISTDIR}/qt63dlls-20040626.tar.bz2 ${DISTDIR}/rp9codecs-20040626.tar.bz2 \
		${DISTDIR}/rp9codecs-win32-20040626.tar.bz2 ${DISTDIR}/win32codecs-20040703.tar.bz2 \
		${DISTDIR}/xanimdlls-20040626.tar.bz2
	fi
}

