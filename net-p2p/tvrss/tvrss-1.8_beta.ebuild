# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/tvrss/tvrss-1.8_beta.ebuild,v 1.1 2006/06/14 00:02:39 squinky86 Exp $

inherit versionator

MY_P="${PN}-$(replace_version_separator 2 '')"
S=${WORKDIR}/${MY_P}

DESCRIPTION="TV RSS is a tool for automating torrent downloads"
HOMEPAGE="http://tvtrss.sourceforge.net/"
SRC_URI="mirror://sourceforge/tvtrss/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="x11-libs/gtk+
	>=dev-lang/perl-5.8.6
	dev-perl/XML-RAI
	dev-perl/glib-perl
	dev-perl/gtk2-perl"

src_install() {
	dobin ${S}/tvrss
}
