# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-hddtemp/gkrellm-hddtemp-0.1.ebuild,v 1.1 2002/08/30 01:49:27 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a GKrellM plugin for hddtemp (which reads the temperature of SMART IDE hard drives)"
SRC_URI="http://coredump.free.fr/linux/${P}.tar.gz"
HOMEPAGE="http://coredump.free.fr/linux/harddrive.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=app-admin/gkrellm-1.2.1"
RDEPEND=">=app-admin/hddtemp-0.2"

src_unpack() {
	unpack ${A} ; cd ${S}
	# patch Makefile
	mv Makefile Makefile.orig
	sed -e "s:^CFLAGS.*:CFLAGS=${CFLAGS} -fPIC:" Makefile.orig > Makefile
}

src_compile() {
	make || die
}

src_install() {
	dodoc README COPYING
	
	insinto /usr/lib/gkrellm/plugins
	doins gkrellm-hddtemp.so
}

pkg_postinst() {
	einfo
	einfo "#######################################################"
	einfo "#                                                     #"
	einfo "#   Please note that hddtemp has to be set suid       #"
	einfo "#   in order to allow regular user to run this        #"
	einfo "#   plugin.                                           #"
	einfo "#                                                     #"
	einfo "#   Please execute (as root):                         #"
	einfo "#   chmod u+s /usr/bin/hddtemp                        #"
	einfo "#   to set the suid bit                               #"
	einfo "#   (this is not done automatically for               #"
	einfo "#   security reasons)                                 #"
	einfo "#                                                     #"
	einfo "#######################################################"
}
