# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-hddtemp/gkrellm-hddtemp-0.1.ebuild,v 1.7 2003/06/08 05:11:03 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a GKrellM plugin for hddtemp (which reads the temperature of SMART IDE hard drives)"
SRC_URI="http://coredump.free.fr/linux/${P}.tar.gz"
HOMEPAGE="http://coredump.free.fr/linux/harddrive.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="=app-admin/gkrellm-1.2*
	>=sys-apps/sed-4"
RDEPEND=">=app-admin/hddtemp-0.2"

src_unpack() {
	unpack ${A} ; cd ${S}
	# patch Makefile
	sed -i "s:^CFLAGS.*:CFLAGS=${CFLAGS} -fPIC:" Makefile
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
	einfo "hddtemp has to be suid root to allow regular users to run this plugin."
	einfo "To make it suid root, run"
	einfo ""
	einfo "\tchmod u+s /usr/bin/hddtemp"
}
