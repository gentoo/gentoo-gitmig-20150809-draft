# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mgm/mgm-1.1.ebuild,v 1.16 2010/07/21 14:54:31 ssuominen Exp $

inherit eutils

DESCRIPTION="Moaning Goat Meter: load and status meter written in Perl"
HOMEPAGE="http://www.linuxmafia.com/mgm/index.html"
SRC_URI="http://www.linuxmafia.com/mgm/${P}.tgz"

KEYWORDS="x86 sparc ~amd64 ppc"
SLOT="0"
LICENSE="as-is"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1
	>=dev-perl/perl-tk-800.024"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
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
