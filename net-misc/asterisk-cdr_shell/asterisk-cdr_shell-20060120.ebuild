# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-cdr_shell/asterisk-cdr_shell-20060120.ebuild,v 1.3 2010/10/28 09:45:57 ssuominen Exp $

inherit eutils toolchain-funcs

MY_PN="cdr_shell"

DESCRIPTION="Asterisk plugin to use an external shell script for cdr handling"
HOMEPAGE="http://www.pbxfreeware.org/"
SRC_URI="http://www.netdomination.org/pub/asterisk/${P}.tar.bz2
	 mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=net-misc/asterisk-1.2.0
	!=net-misc/asterisk-1.0*"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# use asterisk-config
	epatch "${FILESDIR}"/${MY_PN}-20050626-astcfg.diff

	# <asterisk.h> -> <asterisk/asterisk.h>
	sed -i -e "s:<asterisk\.h>:<asterisk/asterisk.h>:" \
		cdr_shell.c
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	insinto /usr/$(get_libdir)/asterisk/modules
	doins cdr_shell.so

	insinto /etc/asterisk
	doins "${FILESDIR}"/cdr.conf

	# fix permissions
	chown -R root:asterisk "${D}"etc/asterisk
	chmod -R u=rwX,g=rX,o= "${D}"etc/asterisk
}
