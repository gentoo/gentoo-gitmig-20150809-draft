# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mgm/mgm-1.1.ebuild,v 1.12 2004/09/02 22:49:41 pvdabeel Exp $

inherit eutils

DESCRIPTION="MGM, the Moaning Goat Meter, is the ultimate sixty-ton cast iron lawn ornament for the desktops of today's hacker set: A gorgeous, highly configurable load and status meter written entirely in Perl. Serious pink-flamingo territory. For evil geniuses only."
HOMEPAGE="http://www.xiph.org/mgm/index.html"
SRC_URI="http://www.xiph.org/mgm/${P}.tgz"

KEYWORDS="x86 sparc ~amd64 ~ppc"
SLOT="0"
LICENSE="as-is"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1
	>=dev-perl/perl-tk-800.024"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_install() {
	dobin mgm || die "dobin failed"
	insinto usr/share/mgm
	doins lib/* || die "doins failed (lib)"
	insinto usr/share/mgm/linux
	doins modules/linux/* || die "doins failed (modules/linux)"
	insinto usr/share/mgm/share
	doins modules/share/* || die "doins failed (modules/share)"
	dohtml doc/*
}
