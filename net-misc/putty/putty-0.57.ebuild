# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-0.57.ebuild,v 1.7 2005/08/21 18:21:24 taviso Exp $

inherit eutils

DESCRIPTION="UNIX port of the famous Telnet and SSH client"

HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/putty/"
SRC_URI="http://the.earth.li/~sgtatham/putty/latest/${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="x86 alpha ppc ~sparc amd64"
IUSE="doc gtk"

RDEPEND="gtk? ( =x11-libs/gtk+-1.2* virtual/x11 )"

DEPEND="${RDEPEND} dev-lang/perl"

src_unpack() {
	unpack ${A}
	ebegin "Generating Makefiles"
		cd ${S}; perl ${S}/mkfiles.pl || die
	eend $?

	ebegin "Setting CFLAGS"
		# bug #103268
		sed -i "s/-Werror//" ${S}/unix/Makefile.gtk
		sed -i "s!-O2!${CFLAGS}!g" ${S}/unix/Makefile.gtk
		# bug #44836
		# prevent gtk-config from being used without gtk
		if ! use gtk; then
			sed -i "s/gtk-config/true/g" ${S}/unix/Makefile.gtk
		fi
	eend $?
}

src_compile() {
	cd ${S}/unix

	# compile all targets if gtk is required, otherwise
	# just non-X utilities.
	if use gtk; then
		emake -f Makefile.gtk
	else
		emake -f Makefile.gtk puttygen plink pscp psftp
	fi
}

src_install() {
	cd ${S}/doc
	use gtk && doman pterm.1 putty.1 puttytel.1
	doman puttygen.1 plink.1

	cd ${S}/unix
	use gtk && dobin pterm putty puttytel
	dobin puttygen plink pscp psftp

	cd ${S}
	dodoc README README.txt LICENCE CHECKLST.txt LATEST.VER website.url
	use doc && dodoc doc/*

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
