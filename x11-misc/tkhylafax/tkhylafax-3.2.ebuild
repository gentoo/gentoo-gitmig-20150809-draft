# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tkhylafax/tkhylafax-3.2.ebuild,v 1.3 2004/02/17 08:03:01 mr_bones_ Exp $

# This is a new ebuild for the tkHylafax client.  This code has barely been
# touched in several years, but it works well enough, and is the only
# *nix client I found that has certain features...

IUSE="tcltk"

S=${WORKDIR}/${P}
DESCRIPTION="Tk-based client for HylaFAX(tm) with rolodex and batch faxing support."
HOMEPAGE="http://www.hylafax.org"
SRC_URI="ftp://ftp.hylafax.org/contrib/tkhylafax/${P}.tar.gz"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="dev-lang/tk"

RDEPEND="${DEPEND}
	app-text/gv"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${P}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.patch
}

src_compile() {
	# no 'econf' here because it only uses a static Makefile :(
	make PREFIX=/usr build || die
}

src_install() {

	dodir /usr/bin /usr/lib/tkhylafax-3.2 /usr/share/man/man1

	# no 'emake' for the same reason.
	make PREFIX=${D}/usr install.lib install.man install.tkhylafax || die

	dodoc INSTALL CHANGES VERSION tkhylafax-3.2.README
}

pkg_postinst() {

	cd /usr/lib/tkhylafax-3.2
	echo 'auto_mkindex /usr/lib/tkhylafax-3.2 *.tcl *.t' | /usr/bin/tclsh

	einfo "This package requires a HylaFAX(tm) server somewhere on your"
	einfo "network (it can also be on the same machine) in order to be"
	einfo "useful.  Read the tkhylafax man page for important tips on"
	einfo "configuring the proper environment variables for the batch"
	einfo "and rolodex data."
}
