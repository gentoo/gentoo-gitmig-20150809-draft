# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/posh/posh-0.2.28.ebuild,v 1.4 2004/03/14 13:27:00 mr_bones_ Exp $

DESCRIPTION="posh is a stripped-down version of pdksh that aims for compliance with Debian's policy, and few extra features"
HOMEPAGE="http://packages.debian.org/posh"
SRC_URI="mirror://debian/pool/main/p/posh/${P/-/_}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall bindir=${D}/bin
	dodoc BUG-REPORTS CONTRIBUTORS ChangeLog NEWS NOTES PROJECTS README
}
