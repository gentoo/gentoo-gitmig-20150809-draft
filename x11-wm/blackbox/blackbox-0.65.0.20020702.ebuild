# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.65.0.20020702.ebuild,v 1.2 2002/07/08 13:47:11 aliz Exp $

#Needed to change ${P} to match actual tarball version name.
#It is an invalid ebuild name. Much simpler this way.

MY_P=${PN}-xft
S=${WORKDIR}/${MY_P}
DESCRIPTION="A small, fast, full-featured window manager for X"
SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/${P}.tar.gz"


HOMEPAGE="http://blackboxwm.sf.net/"

DEPEND="virtual/x11"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

PROVIDE="virtual/blackbox"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use truetype || myconf="${myconf} --disable-xft"

	econf \
		--prefix=/usr \
		--sysconfdir=/etc/X11/blackbox \
		${myconf} || die "configure failure"
	
	doman doc/*.1
	emake || die "emake failure" 
}

src_install () {
	einstall \
		sysconfdir=${D}/etc/X11/blackbox || die "install failure"

	dodoc ChangeLog* AUTHORS LICENSE README* TODO*
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/blackbox
}

