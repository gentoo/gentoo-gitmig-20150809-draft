# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-hddtemp/gkrellm-hddtemp-0.2_beta.ebuild,v 1.6 2004/01/31 22:56:41 mholzer Exp $

MY_P=${P/_beta/-beta}
S=${WORKDIR}/${MY_P}
DESCRIPTION="a GKrellM2 plugin for hddtemp (which reads the temperature of SMART capable hard drives)"
SRC_URI="http://coredump.free.fr/linux/${MY_P}.tar.gz"
HOMEPAGE="http://coredump.free.fr/linux/harddrive.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="=app-admin/gkrellm-2*
	>=sys-apps/sed-4"
RDEPEND=">=app-admin/hddtemp-0.3_beta6"

src_unpack() {
	unpack ${A} ; cd ${S}
	# patch Makefile
	sed -i "s:^CFLAGS.*:CFLAGS=${CFLAGS} -fPIC:" Makefile
}

src_compile() {
	GKRELLM1=0
	GKRELLM2=0
	if [ -f /usr/bin/gkrellm2 ]; then
		GKRELLM2=1
		einfo "Building plugin for gkrellm-2.*"
		make gkrellm2 || die
	elif [ -f /usr/bin/gkrellm ]; then
		GKRELLM1=1
		einfo "Building plugin for gkrellm-1.*"
		make gkrellm1 || die
	fi
}

src_install() {
	dodoc README COPYING
	if [ $GKRELLM1 = 1 ]; then
		einfo "Installing plugin for gkrellm-1.*"
		insinto /usr/lib/gkrellm/plugins
		doins gkrellm-hddtemp.so
	fi
	if [ $GKRELLM2 = 1 ]; then
		einfo "Installing plugin for gkrellm-2.*"
		insinto /usr/lib/gkrellm2/plugins
		doins gkrellm-hddtemp.so
	fi
}

pkg_postinst() {
	einfo "hddtemp has to be suid root to allow regular users to run this plugin."
	einfo "To make it suid root, run"
	einfo ""
	einfo "\tchmod u+s /usr/sbin/hddtemp"
}
