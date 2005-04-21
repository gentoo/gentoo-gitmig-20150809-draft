# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/emovix/emovix-0.9.0_pre1.ebuild,v 1.4 2005/04/21 19:02:47 eradicator Exp $

MY_P="${P/_/}"

DESCRIPTION="Micro Linux distro to boot from a CD and play every video file localized in the CD root."
HOMEPAGE="http://movix.sourceforge.net/"
CODEC_URI="http://www1.mplayerhq.hu/MPlayer/releases/codecs/"
SRC_URI="mirror://sourceforge/movix/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="win32codecs"
DEPEND=">=dev-lang/perl-5.0
	sys-apps/gawk"

RDEPEND="${DEPEND}
	 win32codecs? ( media-libs/win32codecs )
	 virtual/cdrtools"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL README* TODO

	dosym /usr/lib/win32 /usr/share/emovix/codecs
}

