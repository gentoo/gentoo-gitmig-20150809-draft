# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bti/bti-026.ebuild,v 1.2 2010/10/28 09:44:33 ssuominen Exp $

inherit bash-completion

DESCRIPTION="A command line twitter/identi.ca client"
HOMEPAGE="http://gregkh.github.com/bti/"
SRC_URI="mirror://kernel/software/web/bti/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/curl dev-libs/libxml2 dev-libs/libpcre"
RDEPEND="sys-libs/readline"

src_install() {
	einstall || die "bti could not be installed"
	dobin bti-shrink-urls || die "bti could not be installed"
	dodoc bti.example README RELEASE-NOTES ||
		die "bti documentation could not be installed"
	dobashcompletion bti-bashcompletion
}
