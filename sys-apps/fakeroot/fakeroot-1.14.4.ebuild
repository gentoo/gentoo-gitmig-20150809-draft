# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fakeroot/fakeroot-1.14.4.ebuild,v 1.5 2011/03/21 14:53:59 tomka Exp $

DESCRIPTION="Run commands in an environment faking root privileges"
HOMEPAGE="http://packages.qa.debian.org/f/fakeroot.html"
SRC_URI="mirror://debian/pool/main/f/fakeroot/${PF/-/_}.orig.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ppc ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND=""
DEPEND="test? ( app-arch/sharutils )"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog DEBUG NEWS README*
}
