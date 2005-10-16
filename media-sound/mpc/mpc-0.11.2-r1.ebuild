# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpc/mpc-0.11.2-r1.ebuild,v 1.1 2005/10/16 23:26:38 ticho Exp $

inherit bash-completion

DESCRIPTION="A commandline client for Music Player Daemon (media-sound/mpd)"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz http://mercury.chem.pitt.edu/~shank/${P}.tar.gz"
HOMEPAGE="http://www.musicpd.org"
IUSE="nls"

KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~hppa"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc
	nls? ( || ( sys-libs/glibc dev-libs/libiconv ) )"

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable nls iconv) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	mv ${D}/usr/share/doc/mpc/ ${D}/usr/share/doc/${PF}

	dobashcompletion doc/mpc-bashrc
}
