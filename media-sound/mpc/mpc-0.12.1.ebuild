# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpc/mpc-0.12.1.ebuild,v 1.7 2008/12/20 17:34:47 maekke Exp $

inherit bash-completion

DESCRIPTION="A commandline client for Music Player Daemon (media-sound/mpd)"
SRC_URI="http://musicpd.org/uploads/files/${P}.tar.bz2"
HOMEPAGE="http://www.musicpd.org"
IUSE="nls"

KEYWORDS="amd64 hppa ppc ~ppc64 sparc x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="nls? ( || ( sys-libs/glibc dev-libs/libiconv ) )"

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable nls iconv)
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	mv "${D}"/usr/share/doc/mpc/ "${D}"/usr/share/doc/${PF}

	dobashcompletion doc/mpc-bashrc
}
