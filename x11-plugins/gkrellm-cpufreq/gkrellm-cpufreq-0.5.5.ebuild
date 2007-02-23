# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-cpufreq/gkrellm-cpufreq-0.5.5.ebuild,v 1.1 2007/02/23 00:27:58 lack Exp $

inherit multilib

MY_P=${P/gkrellm/gkrellm2}

DESCRIPTION="A Gkrellm2 plugin for displaying and manipulating CPU frequency"
HOMEPAGE="http://iacs.epfl.ch/~winkelma/gkrellm2-cpufreq/"
SRC_URI="http://iacs.epfl.ch/~winkelma/gkrellm2-cpufreq//${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=app-admin/gkrellm-2*"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodoc README
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins cpufreq.so
	exeinto /usr/sbin
	doexe cpufreqset
	doexe cpufreqsetgovernor
	doexe cpufreqnextgovernor
}

pkg_postinst() {
	echo
	einfo "Add this to /etc/sudors to allow users to change cpu governor and speed:"
	einfo "ALL ALL=NOPASSWD:/usr/sbin/cpufreqset [0-9]*"
	einfo "ALL ALL=NOPASSWD:/usr/sbin/cpufreqnextgovernor"
	einfo "ALL ALL=NOPASSWD:/usr/sbin/cpufreqsetgovernor [a-z]*"
	echo
}

