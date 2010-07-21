# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tkhylafax/tkhylafax-3.2.ebuild,v 1.8 2010/07/21 14:52:44 ssuominen Exp $

# This is a new ebuild for the tkHylafax client.  This code has barely been
# touched in several years, but it works well enough, and is the only
# *nix client I found that has certain features...

inherit eutils

DESCRIPTION="Tk-based client for HylaFAX(tm) with rolodex and batch faxing support."
HOMEPAGE="http://www.hylafax.org"
SRC_URI="ftp://ftp.hylafax.org/contrib/tkhylafax/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="dev-lang/tk
	net-misc/hylafax"
RDEPEND="${DEPEND}
	app-text/gv"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PF}-gentoo.patch
}

src_compile() {
	make PREFIX=/usr build || die
}

src_install() {
	dodir /usr/bin /usr/lib/tkhylafax-3.2 /usr/share/man/man1

	make PREFIX="${D}/usr" install.lib install.man install.tkhylafax || die

	dodoc INSTALL CHANGES VERSION tkhylafax-3.2.README
}

pkg_postinst() {
	cd /usr/lib/tkhylafax-3.2
	echo 'auto_mkindex /usr/lib/tkhylafax-3.2 *.tcl *.t' | /usr/bin/tclsh

	einfo "This package requires a HylaFAX(tm) server somewhere on your"
	einfo "network (it can also be on the same machine) in order to be"
	einfo "useful.  You also need the hylafax client command 'sendfax'"
	einfo "Read the tkhylafax man page for important tips on configuring"
	einfo "the proper environment variables for the batch and rolodex data."
}
