# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lkcp/lkcp-0.5.4.ebuild,v 1.2 2007/06/25 17:03:50 peper Exp $

DESCRIPTION="Live Kernel Configuration Panel is an ncurses interface to the run-time Linux kernel configuration data (/proc)"
HOMEPAGE="http://freshmeat.net/projects/lkcp"
SRC_URI="https://webspace.utexas.edu/~hyoussef/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="doc"

RDEPEND="sys-libs/ncurses
	=dev-libs/glib-1*"

DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_compile() {
	cd ${S}/src
	sed -i -e '/^LKCPDIR/s:\/usr\/local\/bin:\$(DESTDIR)\/usr\/bin:' \
		-e '/^\t@$(ECHO) $(ECHOFLAGS) "\\n"$/d' \
		-e '/^\t@$(ECHO) $(ECHOFLAGS) \[+\] Resetting your terminal\.\.\.$/d' \
		-e '/^\t@$(RESET)$/d' Makefile || die "sed failed"
	emake || die "emake failed"
}

src_install() {
	cd ${S}/src
	dodir /usr/bin
	make install DESTDIR="${D}" || die "einstall failed"
	cd ${S}
	mv LICENCE LICENSE
	dodoc AUTHORS CREDITS Changelog README TODO LICENSE
	if use doc; then
		docinto Documentation
		dodoc Documentation/{FSSearch.feature,LKCP.dia,LKCP_diagram-OUTDATED.png,LKCP.Shortcomings,proc.txt,sampledox.conf,ScriptDump.feature}
	fi
}
