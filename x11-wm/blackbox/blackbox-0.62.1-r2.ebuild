# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# Modified by Matthew Jimenez
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.62.1-r2.ebuild,v 1.6 2002/07/08 13:47:11 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small, fast, full-featured window manager for X"
SRC_URI="mirror://sourceforge/blackboxwm/${P}.tar.gz"
HOMEPAGE="http://blackboxwm.sf.net/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

PROVIDE="virtual/blackbox"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	
	myconf="${myconf} --sysconfdir=/etc/X11/blackbox"
	
	econf ${myconf} || die
		
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		datadir=${D}/usr/share \
		sysconfdir=${D}/etc/X11/blackbox \
		install || die

	dodoc ChangeLog* AUTHORS LICENSE README* TODO*
	
	exeinto /etc/X11/Sessions
	doexe $FILESDIR/blackbox
	
}

pkg_postinst() {
	#notify user about the new share dir
	if [ -d /usr/share/Blackbox ]
	then
		einfo
		einfo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		einfo "! Blackbox no longer uses /usr/share/Blackbox as the	!"
		einfo "! default share directory to contain styles and menus.  !"
		einfo "! The default directory is now /usr/share/blackbox	  !"
		einfo "! Please move any files in /usr/share/Blackbox that you !"
		einfo "! wish to keep (personal styles and your menu) into the !"
		einfo "! new directory and modify your menu files to point all !"
		einfo "! listed paths to the new directory.					!"
		einfo "! Also, be sure to update the paths in each user's	  !"
		einfo "! .blackboxrc file found in their home directory.	   !"
		einfo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		einfo
	fi
}

