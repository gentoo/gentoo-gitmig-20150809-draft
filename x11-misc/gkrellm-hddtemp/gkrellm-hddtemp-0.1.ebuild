# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellm-hddtemp/gkrellm-hddtemp-0.1.ebuild,v 1.4 2002/08/02 17:57:38 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a GKrellM plugin for hddtemp (which reads the temperature of SMART IDE hard drives)"
SRC_URI="http://coredump.free.fr/linux/${P}.tar.gz"
HOMEPAGE="http://coredump.free.fr/linux/harddrive.html"

DEPEND=">=app-admin/gkrellm-1.2.1"
RDEPEND=">=app-admin/hddtemp-0.2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

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

	echo
	echo '#######################################################'
	echo '#                                                     #'
	echo '#   Please note that hddtemp has to be set suid       #'
	echo '#   in order to allow regular user to run this        #'
	echo '#   plugin.                                           #'
	echo '#                                                     #'
	echo '#   Please execute (as root):                         #'
	echo '#   chmod u+s /usr/bin/hddtemp                        #'
	echo '#   to set the suid bit                               #'
	echo '#   (this is not done automatically for               #'
	echo '#   security reasons)                                 #'
	echo '#                                                     #'
	echo '#######################################################'

}
