# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avrdude/avrdude-5.0_beta.ebuild,v 1.1 2005/08/23 20:52:32 brix Exp $

MY_P=${P/_beta/-BETA}
S=${WORKDIR}/${MY_P}

DESCRIPTION="AVR Downloader/UploaDEr"
HOMEPAGE="http://savannah.nongnu.org/projects/avrdude"
SRC_URI="http://savannah.nongnu.org/download/avrdude/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE=""
DEPEND="sys-libs/readline
		sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_compile() {
	# no doc subdir in 5.0-BETA
	econf --disable-doc || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS NEWS README \
		ChangeLog ChangeLog-2001 ChangeLog-2002 ChangeLog-2003
}
