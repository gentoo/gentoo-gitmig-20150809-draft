# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/komics/komics-1.0.ebuild,v 1.6 2004/06/04 15:54:59 carlo Exp $

inherit kde
need-kde 3

DESCRIPTION="Komics - a KDE panel applet for fetching comics strips from web."
HOMEPAGE="http://www.orson.it/~domine/komics/"
SRC_URI="http://www.orson.it/~domine/komics/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE=""

S=${WORKDIR}/komics

newdepend "dev-perl/HTML-Parser
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/HTML-Tagset"

