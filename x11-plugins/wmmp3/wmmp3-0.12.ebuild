# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmp3/wmmp3-0.12.ebuild,v 1.5 2004/11/24 23:24:41 weeve Exp $

IUSE=""

DESCRIPTION="Mp3 player dock app for WindowMaker; frontend to mpg123"
HOMEPAGE="http://www.dotfiles.com/software/wmmp3/"
SRC_URI="http://www.dotfiles.com/software/wmmp3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"

DEPEND="virtual/x11
	>=media-sound/mpg123-0.59s-r2"

src_compile()
{
	# override wmmp3 self-calculated cflags
	econf || die "Configuration failed"
	emake prefix="/usr/" || die "Compilation failed"
}

src_install()
{
	einstall || die "Installation failed"
	dodoc AUTHORS COPYING ChangeLog sample.wmmp3 README TODO
}

pkg_postinst()
{
	einfo "Please copy the sample.wmmp3 to your home directory and change it to fit your needs."
}
