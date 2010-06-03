# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fping/fping-2.4_beta2-r2.ebuild,v 1.10 2010/06/03 04:28:33 jer Exp $

DESCRIPTION="A utility to ping multiple hosts at once"
SRC_URI="mirror://gentoo/${PN}-2.4b2_to.tar.gz"
HOMEPAGE="http://www.fping.com/"

SLOT="0"
LICENSE="fping"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

S=${WORKDIR}/fping-2.4b2_to

src_install () {
	dosbin fping || die "Failed to install fping."
	fperms 4555 /usr/sbin/fping #241930
	doman fping.8
	dodoc ChangeLog README
}
