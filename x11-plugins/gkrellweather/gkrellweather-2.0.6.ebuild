# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellweather/gkrellweather-2.0.6.ebuild,v 1.8 2004/03/26 23:10:06 aliz Exp $

IUSE=""
DESCRIPTION="GKrellM2 Plugin that monitors a METAR station and displays weather
info"
SRC_URI="http://kmlinux.fjfi.cvut.cz/~makovick/gkrellm/${P}.tgz"
HOMEPAGE="http://kmlinux.fjfi.cvut.cz/~makovick/gkrellm/index.html"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="=app-admin/gkrellm-2*
	>=sys-apps/sed-4.0.5
	>=net-misc/wget-1.5.3"

RDEPEND="${DEPEND}
	>=dev-lang/perl-5.6.1"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:GrabWeather:GrabWeather2:g" \
		-e "s:/usr/share/gkrellm:/usr/bin:g" \
		gkrellweather.c
}

src_compile() {
	emake PREFIX=/usr || die
}

src_install () {
	exeinto /usr/bin
	newexe GrabWeather GrabWeather2

	insinto /usr/lib/gkrellm2/plugins
	doins gkrellweather.so
	dodoc README ChangeLog COPYING
}
