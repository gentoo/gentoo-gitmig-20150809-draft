# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mgm/mgm-1.1.ebuild,v 1.8 2004/04/11 15:17:36 pyrania Exp $

DESCRIPTION="MGM, the Moaning Goat Meter, is the ultimate sixty-ton cast iron lawn ornament for the desktops of today's hacker set: A gorgeous, highly configurable load and status meter written entirely in Perl. Serious pink-flamingo territory. For evil geniuses only."
HOMEPAGE="http://www.xiph.org/mgm/index.html"
SRC_URI="http://www.xiph.org/mgm/${P}.tgz"
S=${WORKDIR}/${PN}

KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="as-is"

RDEPEND=">=dev-lang/perl-5.6.1
	>=dev-perl/perl-tk-800.024"
src_unpack()
{
	unpack ${P}.tgz

	cd ${S}
	patch ${FILESDIR}/${P}-gentoo.patch
}

src_install()
{
	cd ${S}

	dobin mgm
	dohtml doc/*
	insinto usr/share/mgm
	doins lib/*
	insinto usr/share/mgm/linux
	doins modules/linux/*
	insinto usr/share/mgm/share
	doins modules/share/*
}

