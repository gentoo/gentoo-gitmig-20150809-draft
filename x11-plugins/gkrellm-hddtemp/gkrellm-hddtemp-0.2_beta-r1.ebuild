# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-hddtemp/gkrellm-hddtemp-0.2_beta-r1.ebuild,v 1.1 2007/02/21 20:04:30 lack Exp $

inherit multilib

IUSE=""
MY_P=${P/_beta/-beta}
S=${WORKDIR}/${MY_P}
DESCRIPTION="a GKrellM2 plugin for hddtemp (which reads the temperature of SMART capable hard drives)"
SRC_URI="http://www.guzu.net/linux/${MY_P}.tar.gz"
HOMEPAGE="http://www.guzu.net/linux/hddtemp.php"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"

DEPEND="=app-admin/gkrellm-2*"
RDEPEND="${DEPEND}
	>=app-admin/hddtemp-0.3_beta6"

src_unpack() {
	unpack ${A} ; cd ${S}
	# patch Makefile
	sed -i "s:^CFLAGS.*:CFLAGS=${CFLAGS} -fPIC:" Makefile
}

src_compile() {
	make gkrellm2 || die
}

src_install() {
	dodoc README COPYING

	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins gkrellm-hddtemp.so
}

pkg_postinst() {
	einfo "hddtemp has to be suid root to allow regular users to run this plugin."
	einfo "To make it suid root, run"
	einfo
	einfo "\tchmod u+s /usr/sbin/hddtemp"
}
