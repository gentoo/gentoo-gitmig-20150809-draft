# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ebayagent/ebayagent-0.9.11-r1.ebuild,v 1.3 2005/06/05 23:03:16 mcummings Exp $

inherit eutils

DESCRIPTION="ebay bidding Perl-Script"
HOMEPAGE="http://ebayagent.sf.net"
SRC_URI="mirror://sourceforge/ebayagent/eBayAgent-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="tcltk"
KEYWORDS="x86"

DEPEND="dev-lang/perl
	>=dev-perl/libnet-1.16
	>=dev-perl/URI-1.35
	>=dev-perl/Crypt-SSLeay-0.49
	>=dev-perl/libwww-perl-5.79
	tcltk? ( dev-perl/perl-tk )
	>=dev-perl/TimeDate-1.16"

S=${WORKDIR}/eBayAgent-${PV}

src_compile() {
	epatch ${FILESDIR}/ebayagent.patch

	sed -i -e "s|PREFIX=/usr|PREFIX=${D}${DESTTREE}|" ${S}/Makefile
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dobin ${S}/Tools/repebay ${S}/Tools/runrepebay ${S}/Tools/eBayAgent_Skript
	dosym /usr/bin/eBayAgent /usr/bin/eBayAgent.pl
	doman ${S}/Tools/repebay.1 ${S}/Tools/runrepebay.1 ${S}/eBayAgent.1
	newdoc ${S}/Tools/README_First.txt README_First_Tools.txt
	newdoc ${S}/Tools/README.Debian README_Tools.Debian
	dodoc COPYING INSTALL
	prepalldocs
}
