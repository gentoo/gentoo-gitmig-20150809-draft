# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-leds/gkrellm-leds-0.8.1.ebuild,v 1.8 2004/11/14 20:00:31 kloeri Exp $

IUSE=""
MY_P=${P/rellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GKrellM2 plugin for monitoring keyboard LEDs"
SRC_URI="http://heim.ifi.uio.no/~oyvinha/e107_files/downloads/${MY_P}.tar.gz"
HOMEPAGE="http://www.stud.ifi.uio.no/~oyvinha/gkleds/"

DEPEND="=app-admin/gkrellm-2*"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

src_compile() {
	make || die
}

src_install() {
	insinto /usr/lib/gkrellm2/plugins
	doins gkleds.so

	dodoc COPYING Changelog License TODO INSTALL README
}
