# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.0_alpha4.ebuild,v 1.2 2003/08/02 12:19:46 seemant Exp $

IUSE="nls"

S=${WORKDIR}/${P/_/-}
DESCRIPTION="Openbox is a standards compliant, fast, light-weight, extensible window manager."
HOMEPAGE="http://icculus.org/openbox/"
SRC_URI="http://icculus.org/openbox/releases/${P/_/-}.tar.gz"

DEPEND="virtual/x11"

SLOT="3"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips"

src_compile() {
	econf `use_enable nls` \
		--program-suffix="3" || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	# Add a file for the DM's to recognise it:
	echo "/usr/bin/openbox3" > ob3.xsession
	exeinto /etc/X11/Sessions
	newexe ob3.xsession openbox3
	
	dodoc README AUTHORS ChangeLog TODO
}

