# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mgm/mgm-1.1_p14506.ebuild,v 1.3 2010/07/21 14:54:31 ssuominen Exp $

inherit eutils versionator

DESCRIPTION="Moaning Goat Meter: load and status meter written in Perl"
HOMEPAGE="http://www.linuxmafia.com/mgm/index.html"

# upstream doesn't seem to like making source tarballs anymore. we made this one
# with following command:
# svn co --revision 14506 http://svn.xiph.org/trunk/mgm
#SRC_URI="http://www.linuxmafia.com/mgm/${P}.tgz"
SRC_URI="mirror://gentoo/${P}.tar.bz2" # FIXME

KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
SLOT="0"
LICENSE="as-is"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1
	>=dev-perl/perl-tk-800.024"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-$(get_version_component_range "1-2" )-gentoo.patch"
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
