# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/emovix/emovix-0.9.0_pre1.ebuild,v 1.8 2007/07/12 02:40:43 mr_bones_ Exp $

MY_P="${P/_/}"

DESCRIPTION="Micro Linux distro to boot from a CD and play every video file localized in the CD root."
HOMEPAGE="http://movix.sourceforge.net/"
CODEC_URI="http://www1.mplayerhq.hu/MPlayer/releases/codecs/"
SRC_URI="mirror://sourceforge/movix/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="win32codecs"
DEPEND=">=dev-lang/perl-5.0
	sys-apps/gawk"

RDEPEND="${DEPEND}
	 win32codecs? ( media-libs/win32codecs )
	 virtual/cdrtools"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README* TODO

	dosym /usr/lib/win32 /usr/share/emovix/codecs
}
