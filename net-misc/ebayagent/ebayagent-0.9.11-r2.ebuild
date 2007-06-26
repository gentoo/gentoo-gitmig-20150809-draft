# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ebayagent/ebayagent-0.9.11-r2.ebuild,v 1.7 2007/06/26 02:31:21 mr_bones_ Exp $

inherit eutils

DESCRIPTION="ebay bidding Perl-Script"
HOMEPAGE="http://ebayagent.sf.net"
SRC_URI="mirror://sourceforge/ebayagent/eBayAgent-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="tk"
KEYWORDS="x86"

DEPEND="dev-lang/perl
	>=virtual/perl-libnet-1.16
	>=dev-perl/URI-1.35
	>=dev-perl/Crypt-SSLeay-0.49
	>=dev-perl/libwww-perl-5.79
	tk? ( dev-perl/perl-tk )
	>=dev-perl/TimeDate-1.16"

S=${WORKDIR}/eBayAgent-${PV}

src_compile() {
	sed -i -e "s|PREFIX=/usr|PREFIX=${D}${DESTTREE}|" ${S}/Makefile

	# BUG: 95144 fix path for perl-tk app XeBayAgent.pl to point to eBayAgent
	sed -i -e 's|X_eBayAgentLocation => "|X_eBayAgentLocation => "/usr/bin/eBayAgent|' ${S}/XeBayAgent.pl

	# patching repebay and runrepebay
	epatch ${FILESDIR}/ebayagent.patch
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dosym /usr/bin/eBayAgent /usr/bin/eBayAgent.pl

	dobin ${S}/Tools/repebay ${S}/Tools/runrepebay ${S}/Tools/eBayAgent_Skript
	doman ${S}/Tools/repebay.1 ${S}/Tools/runrepebay.1 ${S}/eBayAgent.1
	newdoc ${S}/Tools/README_First.txt README_First_Tools.txt
	newdoc ${S}/Tools/README.Debian README_Tools.Debian

	# perl-tk (disable XeBayAgent.pl)
	if ! use tk ; then
		rm -rf ${D}/usr/bin/XeBayAgent
	fi

	doman *.1

	prepalldocs
}
