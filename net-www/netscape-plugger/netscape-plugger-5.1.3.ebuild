# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-plugger/netscape-plugger-5.1.3.ebuild,v 1.2 2005/03/23 16:19:25 seemant Exp $

inherit eutils nsplugins

MY_P=${P/netscape-/}
DESCRIPTION="Plugger streaming media plugin"
HOMEPAGE="http://fredrik.hubbe.net/plugger.html"
SRC_URI="http://fredrik.hubbe.net/plugger/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND="www-client/mozilla"

S="${WORKDIR}/${MY_P}"

src_compile () {
	./configure \
	--x-include=/usr/X11R6/include \
	--x-libraries=/usr/X11R6/lib \

	emake
}

src_install () {
	#plugger plugin isntallation and symlinking
	exeinto /opt/netscape/plugins
	doexe plugger.so

	inst_plugin /opt/netscape/plugins/gxineplugin.so

	# plugger docs
	doman plugger.7
	dodoc README

	# plugger helper applications
	exeinto /usr/bin
	doexe plugger-5.1.3
	doexe plugger-oohelper
	doexe plugger-controller

	# install etc file
	insinto /etc
	doins pluggerrc
}
