# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-20040313.ebuild,v 1.3 2004/03/23 22:32:41 weeve Exp $

inherit eutils

DESCRIPTION="UNIX port of the famous Telnet and SSH client"

HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/putty/"
SRC_URI="mirror://gentoo/putty-cvs-${PV}.tar.bz2"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"
IUSE="doc"

RDEPEND="=x11-libs/gtk+-1.2* virtual/x11"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5.8.0
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}

src_unpack() {
	# unpack the tarball...
	unpack ${A}

	# generate the makefiles
	ebegin "Generating Makefiles"
	cd ${S}; ${S}/mkfiles.pl
	eend $?

	# change the CFLAGS to those requested by user.
	ebegin "Setting CFLAGS"
	sed -i "s!-O2!${CFLAGS}!g" ${S}/unix/Makefile.gtk
	eend $?
}

src_compile() {
	# build putty.
	einfo "Building putty..."
	cd ${S}/unix; emake -f Makefile.gtk || die
}

src_install() {

	cd ${S}/unix

	# man pages...
	doman plink.1 pterm.1 putty.1 puttytel.1

	# binaries...
	dobin plink pterm putty puttytel psftp pscp

	cd ${S}

	# docs...
	dodoc README README.txt LICENCE CHECKLST.txt LATEST.VER website.url MODULE
	use doc && dodoc doc/*

	prepallman

	if test ! -c /dev/ptmx; then
		ewarn
		ewarn "The pterm application requires kernel UNIX98 PTY support to operate."
		ewarn
	fi
}
