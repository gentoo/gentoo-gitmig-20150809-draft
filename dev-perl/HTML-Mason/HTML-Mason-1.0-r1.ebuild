# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.0-r1.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="http://www.masonhq.com/download/${P}.tar.gz"
HOMEPAGE="http://www.masonhq.com/"

DEPEND="${DEPEND} dev-perl/Time-HiRes dev-perl/MLDBM"

mydoc="CREDITS UPGRADE"

src_install () {
	
	base_src_install
    dohtml htdocs/*

}
