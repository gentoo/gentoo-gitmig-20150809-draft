# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimsf/iiimsf-12.1_p2002.ebuild,v 1.1 2005/03/30 17:16:25 usata Exp $

inherit iiimf flag-o-matic

DESCRIPTION="server program to provide Input Method facilities via IIIMP"
SRC_URI="http://www.openi18n.org/download/im-sdk/src/${IMSDK_P}.tar.bz2"

KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-libs/libiiimp"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/autoconf
	sys-devel/automake"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	sed -i -e 's,$(IM_LIBDIR)/iiimp,/usr/lib,g' Makefile* \
		|| die "sed Makefile.{am,in} failed."
}

src_compile() {
	export ALLOWED_FLAGS="-O -O1"
	strip-flags
	replace-flags -O[2-9] -O
	iiimf_src_compile
}

src_install() {
	exeinto /usr/lib/im
	doexe src/htt src/htt_server
	exeinto /etc/init.d
	newexe ${FILESDIR}/iiim.initd iiim
	insinto /etc/iiim
	doins ${FILESDIR}/htt.xml.conf

	# unix domain socket
	keepdir /var/run/iiim

	dodoc ChangeLog htt.xml.conf
}
