# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-0.58.ebuild,v 1.1 2005/08/21 19:11:51 taviso Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="UNIX port of the famous Telnet and SSH client"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/putty/"
SRC_URI="http://the.earth.li/~sgtatham/putty/${PV}/${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~amd64"
IUSE="doc gtk ipv6"

RDEPEND="gtk? ( =x11-libs/gtk+-1.2* virtual/x11 )"
DEPEND="${RDEPEND} dev-lang/perl"

src_compile() {
	use gtk || local targets="puttygen plink pscp psftp"
	cd ${S}/unix

	append-flags '-I.././' '-I../charset/' '-I../unix/'

	use ipv6 || append-flags '-DNO_IPV6'
	use gtk  && append-flags '`gtk-config --cflags`'

	emake -f Makefile.gtk ${targets:-all} CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}"
}

src_install() {
	cd ${S}/doc
	use gtk && doman pterm.1 putty.1 puttytel.1
	use doc && dohtml *.html
	dodoc puttydoc.txt
	doman puttygen.1 plink.1

	cd ${S}/unix
	use gtk && dobin pterm putty puttytel
	dobin puttygen plink pscp psftp

	cd ${S}
	dodoc README README.txt LICENCE CHECKLST.txt LATEST.VER

	prepallman

	# install desktop file provided by Gustav Schaffter in #49577
	use gtk && {
		dodir /usr/share/applications
		insinto /usr/share/applications
		doins ${FILESDIR}/putty.desktop
	}

	if test ! -c /dev/ptmx; then
		ewarn
		ewarn "The pterm application requires kernel UNIX98 PTY support to operate."
		ewarn
	fi
}
