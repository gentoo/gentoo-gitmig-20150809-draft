# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/emech/emech-2.8.5.1.ebuild,v 1.1 2004/07/30 00:00:49 swegener Exp $

DESCRIPTION="The EnergyMech is a UNIX compatible IRC bot programmed in the C language"
HOMEPAGE="http://www.energymech.net/"
SRC_URI="http://www.energymech.net/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug session"

DEPEND=""

src_compile() {
	./configure \
		--with-alias \
		--with-dyncmd \
		--with-linkevents \
		--with-linking \
		--with-newbie \
		--with-pipeuser \
		--with-seen \
		--with-telnet \
		--with-wingate \
		--without-profiling \
		--without-superdebug \
		$(use_with session) \
		$(use_with debug) \
		|| die "./configure failed"
	emake CFLAGS="${CFLAGS} -c" || die "emake failed"
}

src_install() {
	dobin src/mech || die "dobin failed"
	newbin genuser mech-genuser || die "newbin failed"
	dodoc sample.set mech.help README VERSIONS checkmech || die "dodoc failed"
}

pkg_postinst() {
	einfo
	einfo "You can find a sample settings file at"
	einfo "/usr/share/doc/${PF}/sample.set.gz"
	einfo
	einfo "NOTE: You need to execute the binary with full path: /usr/bin/mech"
	einfo
}
