# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-0.60.ebuild,v 1.7 2009/04/17 14:55:50 jsbronder Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="UNIX port of the famous Telnet and SSH client"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/putty/"
SRC_URI="http://the.earth.li/~sgtatham/putty/${PV}/${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="doc gtk ipv6"

RDEPEND="!net-proxy/sshproxy
	gtk? ( =x11-libs/gtk+-1.2* )
	!x11-terms/pssh"
DEPEND="${RDEPEND} dev-lang/perl"

src_compile() {
	use gtk && unset ptargets || local ptargets="puttygen plink pscp psftp"

	cd "${S}"/unix

	append-flags '-I.././' '-I../charset/' '-I../unix/'

	use ipv6 || append-flags '-DNO_IPV6'
	use gtk  && append-flags '`gtk-config --cflags`'

	emake -f Makefile.gtk ${ptargets:-all} CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}"
}

src_install() {
	cd "${S}"/doc
	use gtk && doman pterm.1 putty.1 puttytel.1
	use doc && dohtml *.html
	dodoc puttydoc.txt
	doman puttygen.1 plink.1

	cd "${S}"/unix
	use gtk && dobin pterm putty puttytel
	dobin puttygen plink pscp psftp

	cd "${S}"
	dodoc README CHECKLST.txt LATEST.VER

	# install desktop file provided by Gustav Schaffter in #49577
	use gtk && {
		doicon "${FILESDIR}"/${PN}.xpm
		make_desktop_entry "putty" "PuTTY" putty "Network"
	}

	if test ! -c /dev/ptmx; then
		ewarn
		ewarn "The pterm application requires kernel UNIX98 PTY support to operate."
		ewarn
	fi
}
