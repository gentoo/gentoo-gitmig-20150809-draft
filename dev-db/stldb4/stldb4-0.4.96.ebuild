# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/stldb4/stldb4-0.4.96.ebuild,v 1.1 2008/01/06 09:49:39 vapier Exp $

DESCRIPTION="a nice C++ wrapper for db4"
HOMEPAGE="http://witme.sourceforge.net/libferris.web/"
SRC_URI="mirror://sourceforge/witme/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/ferrisloki-3.0.1
	>=dev-libs/libferrisstreams-0.5.2
	dev-libs/STLport"

src_compile() {
	# the --with-pic flag is to workaround broken handling of
	# the berkdb subdir.  note that this package does not
	# actually produce a static archive, so it isn't a big deal
	econf \
		--enable-wrapdebug \
		--enable-rpc \
		--with-uniquename=stldb4 \
		--enable-hiddensymbols \
		--with-pic \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
