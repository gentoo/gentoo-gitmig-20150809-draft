# Copyright 1999-2003 Gentoo Technologies, Inc. and Luke-Jr
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/emovix/emovix-0.8.0_rc2.ebuild,v 1.1 2003/09/13 01:16:25 luke-jr Exp $

DESCRIPTION="eMoviX makes a LiveCD that plays multimedia."
HOMEPAGE="http://movix.sourceforge.net"
SRC_URI="mirror://sourceforge/movix/${P/_rc/rc}.tar.gz"
S=${WORKDIR}/${P/_rc/rc}
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="app-cdr/cdrtools"

src_compile () {
	econf		|| die 'Configure failed'
	emake		|| die 'Make failed'
}

src_install () {
	einstall	|| die 'Install failed'
}
