# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/msetimon/msetimon-2.07.ebuild,v 1.3 2002/10/04 06:43:32 vapier Exp $

DESCRIPTION="A GUI utility for monitoring the SETI@Home client"

NAME="msetimon"

SRC_URI="mirror://sourceforge/msetimon/${NAME}-perl-source-2-07.tar.gz"
HOMEPAGE="http://msetimon.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

INSTALLDIR=/usr/bin

DEPEND="virtual/x11
        sys-devel/perl
        dev-perl/perl-tk"

S=${WORKDIR}/${PN}-perl-source-2-07

src_install () {

	mv ${S}/msetimon.pl msetimon
	exeinto ${INSTALLDIR}
	doexe msetimon || die "install failed"
	dodoc README_msetimon.txt 

}
