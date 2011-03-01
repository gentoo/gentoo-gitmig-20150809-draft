# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/srm/srm-1.2.8-r1.ebuild,v 1.5 2011/03/01 10:15:02 xmw Exp $

inherit eutils

DESCRIPTION="A command-line compatible rm which destroys file contents before unlinking."
HOMEPAGE="http://sourceforge.net/projects/srm/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="!app-misc/secure-delete"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-remove-mount.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README Changes
}

pkg_postinst() {
	ewarn "Please notice that srm will not work as expected with any"
	ewarn "journaled file system (e.g. reiserfs, ext3)."
	ewarn "Take a look at the compressed README inside /usr/share/doc/${PF}"
}
