# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/srm/srm-1.2.11.ebuild,v 1.1 2011/09/28 23:23:23 titanofold Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A command-line compatible rm which destroys file contents before unlinking."
HOMEPAGE="http://sourceforge.net/projects/srm/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="!app-misc/secure-delete"

src_install() {
	emake DESTDIR="${D}" install
	dodoc README
}

pkg_postinst() {
	ewarn "Please notice that srm will not work as expected with any"
	ewarn "journaled file system (e.g. reiserfs, ext3)."
	ewarn "Take a look at the compressed README inside /usr/share/doc/${PF}"
}
