# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/blinkperl/blinkperl-20030301.ebuild,v 1.1 2003/05/09 00:31:37 rac Exp $

MY_P="${PN}-2003-02-08"
S=${WORKDIR}/${PN}

DESCRIPTION="blinkperl is a telnet server, which plays BlinkenLight movies"
SRC_URI="mirror://sourceforge/blinkserv/${MY_P}.tar.gz"
HOMEPAGE="http://blinkserv.sourceforge.net/"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND=""
RDEPEND="dev-lang/perl dev-perl/Term-ANSIScreen"

src_unpack() {
	unpack ${A}

	# please don't hardcode paths like this into programs, folks.
	# that's why makefiles exist.

	sed -i -e 's/local\/share/share/' ${S}/blinkserver.pl
}

src_install() {
	make PREFIX=/usr DESTDIR=${D} install || die

	exeinto /etc/init.d; newexe ${FILESDIR}/blinkperl.rc blinkperl
	insinto /etc/conf.d; newins ${FILESDIR}/blinkperl.confd blinkperl
}
