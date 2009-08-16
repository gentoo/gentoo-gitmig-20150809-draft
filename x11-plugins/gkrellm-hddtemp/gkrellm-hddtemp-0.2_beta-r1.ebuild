# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-hddtemp/gkrellm-hddtemp-0.2_beta-r1.ebuild,v 1.4 2009/08/16 08:47:29 betelgeuse Exp $

EAPI="2"

inherit eutils multilib

IUSE=""
MY_P=${P/_beta/-beta}
S=${WORKDIR}/${MY_P}
DESCRIPTION="a GKrellM2 plugin for hddtemp (which reads the temperature of SMART capable hard drives)"
SRC_URI="http://www.guzu.net/linux/${MY_P}.tar.gz"
HOMEPAGE="http://www.guzu.net/linux/hddtemp.php"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"

CDEPEND="=app-admin/gkrellm-2*[X]
	>=x11-libs/gtk+-2"
DEPEND="${CDEPEND}
	dev-util/pkgconfig"
RDEPEND="${CDEPEND}
	>=app-admin/hddtemp-0.3_beta6"

src_prepare() {
	# patch Makefile
	sed -i "s:^CFLAGS.*:CFLAGS=${CFLAGS} -fPIC:" Makefile || die
}

src_compile() {
	emake gkrellm2 || die
}

src_install() {
	dodoc README || die

	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins gkrellm-hddtemp.so || die
}

pkg_postinst() {
	elog "hddtemp has to be suid root to allow regular users to run this plugin."
	elog "To make it suid root, run"
	elog
	elog "\tchmod u+s /usr/sbin/hddtemp"
}
