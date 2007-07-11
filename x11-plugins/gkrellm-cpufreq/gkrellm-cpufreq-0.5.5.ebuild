# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-cpufreq/gkrellm-cpufreq-0.5.5.ebuild,v 1.3 2007/07/11 20:39:23 mr_bones_ Exp $

inherit gkrellm-plugin

MY_P=${P/gkrellm/gkrellm2}

DESCRIPTION="A Gkrellm2 plugin for displaying and manipulating CPU frequency"
HOMEPAGE="http://iacs.epfl.ch/~winkelma/gkrellm2-cpufreq/"
SRC_URI="http://iacs.epfl.ch/~winkelma/gkrellm2-cpufreq//${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

PLUGIN_SO=cpufreq.so

src_install() {
	gkrellm-plugin_src_install
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
